import datetime
import functools
import os
import pathlib
import re
import shlex
import subprocess
import sys
import time

import colorama
import docopt
from env import (die_hard, get_buildflags, get_ci_environment, get_generator,
                 verbose_output)
from packaging import version
from parse import extract_menu_file


def get_min_cmake_version(file_name):
    with file_name.open() as f:
        s = re.search(r'cmake_minimum_required\(VERSION (.*?) FATAL_ERROR',
                      f.read())
        assert s is not None, "get_min_cmake_version had trouble with file {0}".format(
            file_name)
        cmake_version = s.group(1)
    return cmake_version


def get_system_cmake_version():
    output = subprocess.check_output(['cmake', '--version']).decode('utf-8')
    cmake_version = re.search(r'cmake version (.*?)\n', output).group(1)
    return cmake_version


def streamer(line, *, file_handle=sys.stdout, end='', verbose=True):
    """
    Stream a line to file_handle and return the line.
    """
    if verbose:
        print(line + colorama.Style.RESET_ALL, file=file_handle, end=end)
    return line


def run_command(*, step, command, expect_failure):
    """
    step: string (e.g. 'configuring', 'building', ...); only used in printing
    command: string; this is the command to be run
    expect_failure: bool; if True we do not panic if the command fails
    """
    cmd = shlex.split(command)
    # Stream stdout in verbose mode only
    stdout_streamer = functools.partial(streamer, verbose=verbose_output())
    # stdout starts with the command we want to execute
    stdout = stdout_streamer(command, end='\n')
    # Stream stderr always
    stderr_streamer = functools.partial(streamer, file_handle=sys.stderr)
    stderr = ''
    # subprocess.Popen can be managed as a context and allows us to stream
    # stdout and stderr in real-time
    with subprocess.Popen(
            cmd,
            bufsize=1,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True) as child:
        stdout += ''.join(list(map(stdout_streamer, child.stdout)))
        # Always stream stderr
        stderr = ''.join(list(map(stderr_streamer, child.stderr)))

    return_code = 0
    streamer(
        colorama.Fore.BLUE + colorama.Style.BRIGHT + '  {0} ... '.format(step))
    if child.returncode == 0:
        streamer(colorama.Fore.GREEN + colorama.Style.BRIGHT + 'OK', end='\n')
    else:
        if expect_failure:
            streamer(
                colorama.Fore.YELLOW + colorama.Style.BRIGHT +
                'EXPECTED TO FAIL',
                end='\n')
        else:
            streamer(
                colorama.Fore.RED + colorama.Style.BRIGHT + 'FAILED', end='\n')
            streamer(
                '{cmd}\n {out}{err}'.format(
                    cmd=command, out=stdout, err=stderr),
                end='\n')
            return_code = child.returncode
            if die_hard():
                raise subprocess.CalledProcessError(child.returncode,
                                                    child.args)

    return return_code


def cmake_configuration_command(cmakelists_path, build_directory, generator,
                                definitions_string):
    # Location of CMakeLists.txt, build directory, and generator
    base_options = r'-H"{0}" -B"{1}" -G"{2}"'.format(cmakelists_path,
                                                     build_directory, generator)
    return (r'cmake {0} {1}'.format(base_options, definitions_string))


def run_example(topdir, generator, ci_environment, buildflags, recipe, example):

    # extract global menu
    menu_file = topdir / 'testing' / 'menu.yml'
    skip_global, expect_failure_global, env_global, definitions_global, targets_global = extract_menu_file(
        menu_file, generator, ci_environment)

    sys.stdout.write('\n  {}\n'.format(example))

    # extract local menu
    menu_file = recipe / example / 'menu.yml'
    skip_local, expect_failure_local, env_local, definitions_local, targets_local = extract_menu_file(
        menu_file, generator, ci_environment)

    skip = skip_global or skip_local
    expect_failure = expect_failure_global or expect_failure_local

    # local env vars override global ones
    env = env_global.copy()
    for entry in env_local:
        env[entry] = env_local[entry]

    # local definitions override global ones
    definitions = definitions_global.copy()
    for entry in definitions_local:
        definitions[entry] = definitions_local[entry]

    # Decide configuration from CMAKE_BUILD_TYPE, by default it's Debug
    configuration = definitions[
        'CMAKE_BUILD_TYPE'] if 'CMAKE_BUILD_TYPE' in definitions else 'Debug'

    # local targets extend global targets
    targets = targets_global + targets_local

    for entry in env:
        os.environ[entry] = env[entry]
    definitions_string = ' '.join(
        r'-D{0}="{1}"'.format(entry, os.path.expandvars(definitions[entry]))
        for entry in definitions)

    # we append a time stamp to the build directory
    # to avoid it being re-used when running tests multiple times
    # when debugging on a laptop
    time_stamp = datetime.datetime.fromtimestamp(
        time.time()).strftime('%Y-%m-%d-%H-%M-%S')
    build_directory = recipe / example / 'build-{0}'.format(time_stamp)
    cmakelists_path = recipe / example

    min_cmake_version = get_min_cmake_version(
        cmakelists_path / 'CMakeLists.txt')
    system_cmake_version = get_system_cmake_version()

    if version.parse(system_cmake_version) < version.parse(min_cmake_version):
        sys.stdout.write(
            '\nSKIPPING (system cmake version < min. cmake version for this recipe)\n'
        )
        return 0

    if skip:
        sys.stdout.write('\nSKIPPING recipe (based on menu.yml)\n')
        return 0

    return_code = 0

    custom_script = 'custom.sh'
    custom_script_path = cmakelists_path / custom_script
    if custom_script_path.exists():
        sys.stdout.write('\nRunning a custom.sh script\n')
        # if this directory contains a custom.sh script, we launch it
        step = custom_script
        command = 'bash "{0}" "{1}"'.format(custom_script_path, build_directory)
        return_code += run_command(
            step=step, command=command, expect_failure=expect_failure)
    else:
        # if there is no custom script, we run tests "normally"

        # configure step
        step = 'configuring'
        command = cmake_configuration_command(cmakelists_path, build_directory,
                                              generator, definitions_string)
        return_code += run_command(
            step=step, command=command, expect_failure=expect_failure)

        base_command = r'cmake --build "{0}"'.format(build_directory)

        # build step
        step = '{0} configuration {1}'.format('building', configuration)
        command = base_command + ' --config {0} -- {1}'.format(
            configuration, buildflags)
        return_code += run_command(
            step=step, command=command, expect_failure=expect_failure)

        # extra targets
        for target in targets:
            step = '{0} configuration {1}'.format(target, configuration)

            # on VS '--target test' fails but '--target RUN_TESTS' seems to work
            if generator.startswith('Visual Studio'):
                if target == 'test':
                    target = 'RUN_TESTS'

            command = base_command + ' --config {0} --target {1}'.format(
                configuration, target)
            return_code += run_command(
                step=step, command=command, expect_failure=expect_failure)

        # execute dashboard script, if it exists
        dashboard_script = 'dashboard.cmake'
        dashboard_script_path = cmakelists_path / dashboard_script
        if dashboard_script_path.exists():
            # if this directory contains a dashboard.cmake script, we launch it
            step = dashboard_script
            command = 'ctest -C {0} -S "{1}" -DCTEST_CMAKE_GENERATOR="{2}" {3}'.format(
                configuration, dashboard_script_path, generator,
                definitions_string)
            return_code += run_command(
                step=step, command=command, expect_failure=expect_failure)

    for entry in env:
        os.environ.pop(entry)

    return return_code


def main(arguments):

    _this_dir = pathlib.Path(__file__).resolve().parent
    topdir = _this_dir.parent

    buildflags = get_buildflags()
    generator = get_generator()
    ci_environment = get_ci_environment()

    # glob recipes
    recipes = [r for r in sorted(topdir.glob(arguments['<regex>']))]
    if not recipes:
        raise RuntimeError('Empty list of recipes to test: provide a valid regex')

    # Set NINJA_STATUS environment variable
    os.environ['NINJA_STATUS'] = '[Built edge %f of %t in %e sec]'

    colorama.init()
    return_code = 0
    for recipe in recipes:

        # extract title from title.txt
        title = recipe / 'title.txt'
        with title.open() as f:
            line = f.readline().rstrip()
            streamer(
                '\n' + colorama.Back.BLUE + 'recipe: {0}'.format(line),
                end='\n')

        # Glob examples
        examples = sorted(recipe.glob('*example*'))

        for example in examples:
            return_code += run_example(topdir, generator, ci_environment,
                                       buildflags, recipe, example)

    colorama.deinit()
    sys.exit(return_code)


if __name__ == '__main__':
    options = """Run continuous integration

    Usage:
        collect_tests.py <regex>
        collect_tests.py (-h | --help)

    Options:
        -h --help     Show this screen.

    """
    # parse command line args
    try:
        arguments = docopt.docopt(options, argv=None)
    except docopt.DocoptExit:
        sys.stderr.write('ERROR: bad input to {0}\n'.format(sys.argv[0]))
        sys.stderr.write(options)
        sys.exit(-1)
    main(arguments)
