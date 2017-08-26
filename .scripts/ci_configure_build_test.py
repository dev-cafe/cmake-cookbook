#!/usr/bin/env python

from __future__ import print_function  # Only Python 2.x
import glob
import subprocess
import os


def run_command(cmd):
    """
    Accepts a list
    Code copied from: https://stackoverflow.com/a/4417735
    """
    popen = subprocess.Popen(cmd,
                             stdout=subprocess.PIPE,
                             universal_newlines=True)
    for stdout_line in iter(popen.stdout.readline, ""):
        yield stdout_line
    popen.stdout.close()
    return_code = popen.wait()
    if return_code:
        raise subprocess.CalledProcessError(return_code, cmd)


def main():
    # Glob recipes excluding recipe-0000
    recipes = [r for r in sorted(glob.glob('recipe-*')) if "0000" not in r]
    # Get some environment variables
    generator = os.environ.get('GENERATOR')
    buildflags = os.environ.get('BUILDFLAGS')
    topdir = ''
    if os.environ.get('TRAVIS'):
        topdir = os.environ.get('TRAVIS_BUILD_DIR')
    elif os.environ.get('APPVEYOR'):
        topdir = os.environ.get('APPVEYOR_BUILD_FOLDER')
    else:
        # Local testing
        generator = 'Unix Makefiles'
        buildflags = 'VERBOSE=1'
        topdir = os.getcwd()

    for recipe in recipes:
        recipe_dir = os.path.abspath(recipe)
        os.chdir(recipe_dir)
        # Glob examples
        examples = [e for e in sorted(glob.glob('*-example'))]
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
