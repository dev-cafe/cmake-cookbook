#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os
import sys
import datetime
import time


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
                success_predicate):
    """
    step: string (e.g. 'configuring', 'building', ...); only used in printing
    command: string; this is the command to be run
    expect_failure: bool; if True we do not panic if the command fails
    skip_predicate: bool(stdout, stderr)
    success_predicate: bool(stdout)
    """
    popen = subprocess.Popen(command,
                             shell=True,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

    stdout_coded, stderr_coded = popen.communicate()
    stdout = stdout_coded.decode('UTF-8')
    stderr = stderr_coded.decode('UTF-8')

    return_code = 0
    if not skip_predicate(stdout, stderr):
        sys.stdout.write('  {0} ... '.format(step))
        if success_predicate(stdout):
            # we found all strings, assume there are no errors
            sys.stdout.write('OK\n')
        else:
            if expect_failure:
                sys.stdout.write('EXPECTED TO FAIL\n')
            else:
                sys.stdout.write('FAILED\n')
                sys.stderr.write(stdout + stderr + '\n')
                return_code = 1
        sys.stdout.flush()
        sys.stderr.flush()

    return return_code


def get_list_of_recipes_to_run(topdir):
    # we expect the script to be executed as: python .scripts/ci_configure_build_test.py regex
    # stop here if the number of arguments is not right
    if len(sys.argv) == 2:
        # we assume the last positional argument to be the regex to glob after
        glob_regex = sys.argv[-1]
    else:
        sys.stderr.write('ERROR: script expects one argument, example:\n')
        sys.stderr.write("python .scripts/ci_configure_build_test.py 'Chapter*/recipe-*'\n")
        sys.exit(1)
    # glob recipes
    return [r for r in sorted(glob.glob(os.path.join(topdir, glob_regex)))]


def parse_yaml():
    '''
    If recipe directory contains a file called menu.yml, we parse it.
    '''
    import yaml
    import sys
    file_name = 'menu.yml'
    if os.path.isfile(file_name):
        with open(file_name, 'r') as f:
            try:
                config = yaml.load(f, yaml.SafeLoader)
            except yaml.YAMLError as exc:
                print(exc)
                sys.exit(-1)
        return config
    return {}


def main():
    topdir = get_topdir()
    buildflags = get_buildflags()
    generator = get_generator()
    recipes = get_list_of_recipes_to_run(topdir)
    ci_environment = get_ci_environment()

    # Set NINJA_STATUS environment variable
    os.environ['NINJA_STATUS'] = '[Built edge %f of %t in %e sec]'

    return_code = 0
    for recipe in recipes:
        os.chdir(recipe)

        # extract title from README.md
        with open('README.md', 'r') as f:
            for line in f.read().splitlines():
                if line[0:2] == '# ':
                    print('\nrecipe: {0}'.format(line[2:]))

        # Glob examples
        examples = [e for e in sorted(glob.glob(os.path.join(recipe, '*example')))]

        # TODO we need to get rid of this
        # Remove Fortran examples if generator is Visual Studio
        if generator == 'Visual Studio 14 2015':
            examples = filter(lambda x: 'fortran' not in x, examples)

        for example in examples:

            os.chdir(example)
            sys.stdout.write('\n  {}\n'.format(example))

            # we append a time stamp to the build directory
            # to avoid it being re-used when running tests multiple times
            # when debugging on a laptop
            time_stamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d-%H-%M-%S')
            build_directory = 'build-{0}'.format(time_stamp)

            config = parse_yaml()

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

            # configure step
            step = 'configuring'
            command = '{0} cmake -H. -B{1} -G"{2}"{3}'.format(env, build_directory, generator, definitions)
            expected_strings = [
                '-- Configuring done',
                '-- Generating done',
                ]
            skip_predicate = lambda stdout, stderr: False
            success_predicate = lambda stdout: all([x in stdout for x in expected_strings])
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       success_predicate=success_predicate)

            os.chdir(build_directory)

            # build step
            step = 'building'
            command = 'cmake --build . -- {0}'.format(buildflags)
            expected_strings = [
                'Built target',
                'Built edge',
                ]
            # skip if build step produces zero output
            # in this case we only configure and test
            # used in chapter 12
            skip_predicate = lambda stdout, stderr: ('Nothing to be done' in stdout or 'ninja: no work to do.' in stdout)
            success_predicate = lambda stdout: any([x in stdout for x in expected_strings])
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       success_predicate=success_predicate)

            # test step
            step = 'testing'
            command = 'ctest'
            skip_predicate = lambda stdout, stderr: 'No test configuration file found!' in stderr
            success_predicate = lambda stdout: '100% tests passed, 0 tests failed' in stdout
            return_code += run_command(step=step,
                                       command=command,
                                       expect_failure=expect_failure,
                                       skip_predicate=skip_predicate,
                                       success_predicate=success_predicate)

    sys.exit(return_code)


if __name__ == '__main__':
    main()
