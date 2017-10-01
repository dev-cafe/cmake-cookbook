#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os
import sys


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


def get_list_of_recipes_to_run():
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
    return [r for r in sorted(glob.glob(glob_regex)) if '0000' not in r]


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
        return 0
    else:
        sys.stdout.write('FAILED\n')
        sys.stderr.write(errors + '\n')
        return 1


def main():
    recipes = get_list_of_recipes_to_run()
    generator, buildflags, topdir, is_visual_studio = get_env_variables()

    return_code = 0
    for recipe in recipes:
        recipe_dir = os.path.abspath(recipe)
        os.chdir(recipe_dir)
        # Glob examples
        examples = [e for e in sorted(glob.glob('*-example'))]

        # TODO we need to get rid of this
        # Remove Fortran examples if generator is Visual Studio
        if is_visual_studio:
            examples = filter(lambda x: 'fortran' not in x, examples)

        for example in examples:

            os.chdir(os.path.abspath(example))
            sys.stdout.write('{}/{}\n'.format(recipe, example))

            # configure step
            sys.stdout.write('  configuring ... ')
            errors = run_command(command='cmake -H. -Bbuild -G"{0}"'.format(generator),
                                 expected_strings=['-- Configuring done',
                                                   '-- Generating done'])
            return_code += handle_errors(errors)

            # build step
            os.chdir('build')
            sys.stdout.write('  building ... ')
            errors = run_command(command='cmake --build . -- {0}'.format(buildflags),
                                 expected_strings=['Built target'])
            return_code += handle_errors(errors)

            os.chdir(recipe_dir)
        os.chdir(topdir)
    sys.exit(return_code)


if __name__ == '__main__':
    main()
