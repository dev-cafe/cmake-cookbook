from __future__ import print_function  # Only Python 2.x

import datetime
import glob
import os
import re
import subprocess
import sys
import time

import colorama
import docopt
from packaging import version

from env import (get_buildflags, get_ci_environment, get_generator,
                 verbose_output)
from parse import extract_menu_file


def get_min_cmake_version(file_name):
    with open(file_name, 'r') as f:
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


def run_command(step, command, expect_failure):
    """
    step: string (e.g. 'configuring', 'building', ...); only used in printing
    command: string; this is the command to be run
    expect_failure: bool; if True we do not panic if the command fails
    """
    child = subprocess.Popen(
        command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    stdout_coded, stderr_coded = child.communicate()
    stdout = stdout_coded.decode('UTF-8')
    stderr = stderr_coded.decode('UTF-8')

    child_return_code = child.returncode

    return_code = 0
    sys.stdout.write(
        colorama.Fore.BLUE + colorama.Style.BRIGHT + '  {0} ... '.format(step))
    if child_return_code == 0:
        sys.stdout.write(colorama.Fore.GREEN + colorama.Style.BRIGHT + 'OK\n')
        if verbose_output():
            sys.stdout.write(stdout + stderr + '\n')
    else:
        if expect_failure:
            sys.stdout.write(colorama.Fore.YELLOW + colorama.Style.BRIGHT +
                             'EXPECTED TO FAIL\n')
        else:
            sys.stdout.write(
                colorama.Fore.RED + colorama.Style.BRIGHT + 'FAILED\n')
            sys.stderr.write(stdout + stderr + '\n')
            return_code = child_return_code
    sys.stdout.flush()
    sys.stderr.flush()

    return return_code


def run_example(topdir, generator, ci_environment, buildflags, recipe, example):

    # extract global menu
    menu_file = os.path.join(topdir, 'testing', 'menu.yml')
    expect_failure_global, env_global, definitions_global, targets_global, configurations_global = extract_menu_file(
        menu_file, generator, ci_environment)

    sys.stdout.write('\n  {}\n'.format(example))

    # extract local menu
    menu_file = os.path.join(recipe, example, 'menu.yml')
    expect_failure_local, env_local, definitions_local, targets_local, configurations_local = extract_menu_file(
        menu_file, generator, ci_environment)

    expect_failure = expect_failure_global or expect_failure_local

    # local env vars override global ones
    env = env_global.copy()
    for entry in env_local:
        env[entry] = env_local[entry]

    # local definitions override global ones
    definitions = definitions_global.copy()
    for entry in definitions_local:
        definitions[entry] = definitions_local[entry]

    # local targets extend global targets
    targets = targets_global + targets_local

    # local configurations override global ones
    configurations = configurations_local.copy() if configurations_local else configurations_global.copy()

    for entry in env:
        os.environ[entry] = env[entry]
    definitions_string = ' '.join(
        '-D{0}={1}'.format(entry, definitions[entry]) for entry in definitions)

    # we append a time stamp to the build directory
    # to avoid it being re-used when running tests multiple times
    # when debugging on a laptop
    time_stamp = datetime.datetime.fromtimestamp(
        time.time()).strftime('%Y-%m-%d-%H-%M-%S')
    build_directory = os.path.join(recipe, example,
                                   'build-{0}'.format(time_stamp))
    cmakelists_path = os.path.join(recipe, example)

    min_cmake_version = get_min_cmake_version(
        os.path.join(cmakelists_path, 'CMakeLists.txt'))
    system_cmake_version = get_system_cmake_version()

    if version.parse(system_cmake_version) < version.parse(min_cmake_version):
        sys.stdout.write(
            '\nSKIPPING (system cmake version < min. cmake version for this recipe)\n'
        )
        return 0

    return_code = 0

    custom_sh_path = os.path.join(cmakelists_path, 'custom.sh')
    if os.path.exists(custom_sh_path):
        # if this directory contains a custom.sh script, we launch it
        step = 'custom.sh'
        command = '{0} {1}'.format(custom_sh_path, build_directory)
        return_code += run_command(
            step=step, command=command, expect_failure=expect_failure)
    else:
        # if there is no custom script, we run tests "normally"

        # configure step
        step = 'configuring'
        command = 'cmake -H{0} -B{1} -G"{2}" {3}'.format(
            cmakelists_path, build_directory, generator, definitions_string)
        return_code += run_command(
            step=step, command=command, expect_failure=expect_failure)

        base_command = 'cmake --build {0}'.format(build_directory)

        # build step
        step = 'building'
        for c in configurations:
            confstr = ' configuration {}'.format(c)
            step += confstr
            config = '--config {}'.format(c)
            # append configuration to base command
            base_command += ' {0}'.format(config)
            # form build command by appending tool-native buildflags
            command = base_command + ' -- {0}'.format(buildflags)
            # ready to roll
            return_code += run_command(
                step=step, command=command, expect_failure=expect_failure)

            # extra targets
            for target in targets:
                step = target + confstr
                command = base_command + ' --target {0}'.format(target)
                return_code += run_command(
                    step=step, command=command, expect_failure=expect_failure)

    for entry in env:
        os.environ.pop(entry)

    return return_code


def main(arguments):

    _this_dir = os.path.dirname(os.path.realpath(__file__))
    topdir = os.path.join(_this_dir, '..')

    buildflags = get_buildflags()
    generator = get_generator()
    ci_environment = get_ci_environment()

    # glob recipes
    recipes = [
        r
        for r in sorted(glob.glob(os.path.join(topdir, arguments['<regex>'])))
    ]

    # Set NINJA_STATUS environment variable
    os.environ['NINJA_STATUS'] = '[Built edge %f of %t in %e sec]'

    colorama.init(autoreset=True)
    return_code = 0
    for recipe in recipes:

        # extract title from title.txt
        with open(os.path.join(recipe, 'title.txt'), 'r') as f:
            line = f.readline()
            print(colorama.Back.BLUE + '\nrecipe: {0}'.format(line))

        # Glob examples
        examples = sorted(glob.glob(os.path.join(recipe, '*example*')))

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
