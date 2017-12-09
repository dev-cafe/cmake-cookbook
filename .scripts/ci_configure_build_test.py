#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os
import sys
import datetime
import time
import docopt
import colorama


def get_ci_environment():
    if os.environ.get('TRAVIS'):
        travis_os_name = os.environ.get('TRAVIS_OS_NAME')
        if travis_os_name == 'osx':
            ci_environment = 'travis-osx'
        else:
            ci_environment = 'travis-linux'
    elif os.environ.get('APPVEYOR'):
        ci_environment = 'appveyor'
    elif os.environ.get('DRONE'):
        ci_environment = 'drone'
    else:
        ci_environment = 'local'
    return ci_environment


def get_generator():
    generator = os.environ.get('GENERATOR')
    if generator is None:
        generator = 'Ninja'
    return generator


def get_buildflags():
    buildflags = os.environ.get('BUILDFLAGS')
    if buildflags is None:
        # this fails on my laptop with Unix Makefiles (?)
#       buildflags = '-v'
        buildflags = ''
    return buildflags


def get_topdir():
    if os.environ.get('TRAVIS'):
        topdir = os.environ.get('TRAVIS_BUILD_DIR')
    elif os.environ.get('APPVEYOR'):
        topdir = os.environ.get('APPVEYOR_BUILD_FOLDER')
    elif os.environ.get('DRONE'):
        topdir = os.getcwd()
    else:
        topdir = os.getcwd()
    return topdir


def run_command(step,
                command,
                expect_failure,
                skip_predicate,
                verbose):
    """
    step: string (e.g. 'configuring', 'building', ...); only used in printing
    command: string; this is the command to be run
    expect_failure: bool; if True we do not panic if the command fails
    skip_predicate: bool(stdout, stderr)
    verbose: bool; if True always print stdout and stderr from command
    """
    child = subprocess.Popen(command,
                             shell=True,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

    stdout_coded, stderr_coded = child.communicate()
    stdout = stdout_coded.decode('UTF-8')
    stderr = stderr_coded.decode('UTF-8')

    child_return_code = child.returncode

    return_code = 0
    if not skip_predicate(stdout, stderr):
        sys.stdout.write(colorama.Fore.BLUE + colorama.Style.BRIGHT + '  {0} ... '.format(step))
        if child_return_code == 0:
            sys.stdout.write(colorama.Fore.GREEN + colorama.Style.BRIGHT + 'OK\n')
            if verbose:
                sys.stdout.write(stdout + stderr + '\n')
        else:
            if expect_failure:
                sys.stdout.write(colorama.Fore.YELLOW + colorama.Style.BRIGHT + 'EXPECTED TO FAIL\n')
            else:
                sys.stdout.write(colorama.Fore.RED + colorama.Style.BRIGHT + 'FAILED\n')
                sys.stderr.write(stdout + stderr + '\n')
                return_code = child_return_code
        sys.stdout.flush()
        sys.stderr.flush()

    return return_code


def parse_yaml(file_name):
    '''
    Parse file_name and return dictionary.
    If file does not exist, return empty dictionary.
    '''
    import yaml
    import sys
    if os.path.isfile(file_name):
        with open(file_name, 'r') as f:
            try:
                config = yaml.load(f, yaml.SafeLoader)
            except yaml.YAMLError as exc:
                print(exc)
                sys.exit(-1)
        return config
    return {}


def main(arguments):
    topdir = get_topdir()
    buildflags = get_buildflags()
    generator = get_generator()
    # glob recipes
    recipes = [r for r in sorted(glob.glob(os.path.join(topdir, arguments['<regex>'])))]
    ci_environment = get_ci_environment()

    # Set NINJA_STATUS environment variable
    os.environ['NINJA_STATUS'] = '[Built edge %f of %t in %e sec]'

    colorama.init(autoreset=True)
    return_code = 0
    for recipe in recipes:

        # extract title from README.md
        with open(os.path.join(recipe, 'README.md'), 'r') as f:
            for line in f.read().splitlines():
                if line[0:2] == '# ':
                    print(colorama.Back.BLUE + '\nrecipe: {0}'.format(line[2:]))

        # Glob examples
        examples = [e for e in sorted(glob.glob(os.path.join(recipe, '*example')))]

        # TODO we need to get rid of this
        # Remove Fortran examples if generator is Visual Studio
        if generator == 'Visual Studio 14 2015':
            examples = filter(lambda x: 'fortran' not in x, examples)

        for example in examples:

            sys.stdout.write('\n  {}\n'.format(example))

            config = parse_yaml(os.path.join(recipe, example, 'menu.yml'))

            failing_generators = []
            if 'failing_generators' in config[ci_environment]:
                failing_generators = config[ci_environment]['failing_generators']
            expect_failure = generator in failing_generators

            # assemble env vars
            env = ''
            if 'env' in config[ci_environment]:
                for entry in config[ci_environment]['env']:
                    for k in entry.keys():
                        v = entry[k]
                        env += '{0}={1} '.format(k, v)

            # assemble definitions
            definitions = ''
            if 'definitions' in config[ci_environment]:
                for entry in config[ci_environment]['definitions']:
                    for k in entry.keys():
                        v = entry[k]
                        definitions += ' -D{0}={1}'.format(k, v)

            # we append a time stamp to the build directory
            # to avoid it being re-used when running tests multiple times
            # when debugging on a laptop
            time_stamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d-%H-%M-%S')
            build_directory = os.path.join(recipe, example, 'build-{0}'.format(time_stamp))
            cmakelists_path = os.path.join(recipe, example)

            # configure step
            step = 'configuring'
            command = '{0} cmake -H{1} -B{2} -G"{3}"{4}'.format(env, cmakelists_path, build_directory, generator, definitions)
            skip_predicate = lambda stdout, stderr: False
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       verbose=arguments['--verbose'])

            os.chdir(build_directory)

            # build step
            step = 'building'
            command = 'cmake --build . -- {0}'.format(buildflags)
            skip_predicate = lambda stdout, stderr: False
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       verbose=arguments['--verbose'])

            # test step
            step = 'testing'
            command = 'ctest'
            skip_predicate = lambda stdout, stderr: 'No test configuration file found!' in stderr
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       verbose=arguments['--verbose'])

            os.chdir(topdir)

    colorama.deinit()
    sys.exit(return_code)


if __name__ == '__main__':
    options="""Run continuous integration

    Usage:
        ci_configure_build_test.py <regex>
        ci_configure_build_test.py <regex> (-v | --verbose)
        ci_configure_build_test.py (-h | --help)

    Options:
        -h --help     Show this screen.
        -v --verbose  Print (almost) everything

    """
    # parse command line args
    try:
        arguments = docopt.docopt(options, argv=None)
    except docopt.DocoptExit:
        sys.stderr.write('ERROR: bad input to {0}\n'.format(sys.argv[0]))
        sys.stderr.write(options)
        sys.exit(-1)
    main(arguments)
