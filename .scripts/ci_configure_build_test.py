#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os
import sys
import datetime
import time


def run_command(command, expected_strings):
    """
    Executes a command (string) and checks whether all expected strings (list)
    are present in the stdout.
    If all strings are present, it returns errors as None.
    If not all are present, it combines stdout and stderr and returns it as error
    and lets the caller deal with it.
    We do this in this a bit convoluted way since CMake sometimes/often (?)
    puts warnings into stderr so we cannot just check for the presence of stderr.
    """
    popen = subprocess.Popen(command,
                             shell=True,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)

    stdout_coded, stderr_coded = popen.communicate()
    stdout = stdout_coded.decode('UTF-8')
    stderr = stderr_coded.decode('UTF-8')

    if all([s in stdout for s in expected_strings]):
        # we found all strings, assume there are no errors
        # and return None
        errors = None
    else:
        errors = stdout + stderr

    return errors


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
    # glob recipes but exclude recipe-0000
    return [r for r in sorted(glob.glob(os.path.join(topdir, glob_regex))) if '0000' not in r]


def get_env_variables():
    generator = os.environ.get('GENERATOR')
    buildflags = os.environ.get('BUILDFLAGS')
    topdir = ''
    is_visual_studio = True if generator == 'Visual Studio 14 2015' else False
    if os.environ.get('TRAVIS'):
        topdir = os.environ.get('TRAVIS_BUILD_DIR')
    elif os.environ.get('APPVEYOR'):
        topdir = os.environ.get('APPVEYOR_BUILD_FOLDER')
    else:
        # Local testing
        generator = 'Unix Makefiles'
        buildflags = 'VERBOSE=1'
        topdir = os.getcwd()
    return generator, buildflags, topdir, is_visual_studio


def handle_errors(errors):
    if errors is None:
        sys.stdout.write('OK\n')
        return_code = 0
    else:
        sys.stdout.write('FAILED\n')
        sys.stderr.write(errors + '\n')
        return_code = 1
    sys.stdout.flush()
    sys.stderr.flush()
    return return_code


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
    generator, buildflags, topdir, is_visual_studio = get_env_variables()
    recipes = get_list_of_recipes_to_run(topdir)

    return_code = 0
    for recipe in recipes:
        os.chdir(recipe)

        # extract title from README.md
        with open('README.md', 'r') as f:
            for line in f.read().splitlines():
                if line[0:2] == '# ':
                    print('\nrecipe: {0}'.format(line[2:]))

        # Glob examples
        examples = [e for e in sorted(glob.glob(os.path.join(recipe, '*-example')))]

        # TODO we need to get rid of this
        # Remove Fortran examples if generator is Visual Studio
        if is_visual_studio:
            examples = filter(lambda x: 'fortran' not in x, examples)

        for example in examples:

            os.chdir(example)
            sys.stdout.write('  {}/{}\n'.format(recipe, example))

            # we append a time stamp to the build directory
            # to avoid it being re-used when running tests multiple times
            # when debugging on a laptop
            time_stamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d-%H:%M:%S')
            build_directory = 'build-{0}'.format(time_stamp)

            # configure step
            sys.stdout.write('    configuring ... ')
            sys.stdout.flush()
            config = parse_yaml()
            env = ''
            if 'env' in config:
                for k in config['env']:
                    v = config['env'][k]
                    env += '{0}={1} '.format(k, v)
            definitions = ''
            if 'definitions' in config:
                for k in config['definitions']:
                    v = config['definitions'][k]
                    definitions += ' -D{0}={1}'.format(k, v)
            command = '{0} cmake -H. -B{1} -G"{2}"{3}'.format(env, build_directory, generator, definitions)
            errors = run_command(command=command,
                                 expected_strings=['-- Configuring done',
                                                   '-- Generating done'])
            return_code += handle_errors(errors)

            # build step
            os.chdir(build_directory)
            sys.stdout.write('    building ... ')
            sys.stdout.flush()
            errors = run_command(command='cmake --build . -- {0}'.format(buildflags),
                                 expected_strings=['Built target'])
            return_code += handle_errors(errors)

    sys.exit(return_code)


if __name__ == '__main__':
    main()
