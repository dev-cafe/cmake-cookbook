#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os
import sys


def run_command(command):
    """
    command is a list
    code adapted from: https://stackoverflow.com/a/4417735
    """
    popen = subprocess.Popen(command,
                             stdout=subprocess.PIPE,
                             universal_newlines=True)
    for stdout_line in iter(popen.stdout.readline, ""):
        yield stdout_line
    popen.stdout.close()
    return_code = popen.wait()
    if return_code:
        raise subprocess.CalledProcessError(return_code, command)


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


def main():
    recipes = get_list_of_recipes_to_run()
    generator, buildflags, topdir, is_visual_studio = get_env_variables()

    for recipe in recipes:
        recipe_dir = os.path.abspath(recipe)
        os.chdir(recipe_dir)
        # Glob examples
        examples = [e for e in sorted(glob.glob('*-example'))]
        # Remove Fortran examples if generator is Visual Studio
        if is_visual_studio:
            examples = filter(lambda x: 'fortran' not in x, examples)
        for example in examples:
            os.chdir(os.path.abspath(example))
            print('{} and {}'.format(recipe, example))
            # Configure
            configure = run_command(['cmake', '-H.',
                                     '-Bbuild', '-G' + generator])
            [print(x, end="") for x in configure]
            os.chdir('build')
            # Build
            build = run_command(['cmake', '--build', '.', '--', buildflags])
            [print(x, end="") for x in build]
            # Test
            # test = run_command(['ctest'])
            # [print(x, end="") for x in test]
            os.chdir(recipe_dir)
        os.chdir(topdir)


if __name__ == '__main__':
    main()
