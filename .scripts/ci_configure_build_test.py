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
    recipes = [os.path.abspath(r)
               for r in glob.glob('recipe-*') if "0000" not in r]
    # For local testing
    # generator = 'Unix Makefiles'
    # buildflags = 'VERBOSE=1'
    # topdir = '/home/roberto/Workspace/robertodr/cmake-recipes'
    # Get some environment variables
    generator = os.environ.get('GENERATOR')
    buildflags = os.environ.get('BUILDFLAGS')
    topdir = ''
    if os.environ.get('TRAVIS'):
        topdir = os.environ.get('TRAVIS_BUILD_DIR')
    elif os.environ.get('APPVEYOR'):
        topdir = os.environ.get('APPVEYOR_BUILD_FOLDER')
    else:
        raise RuntimeError('Only Travis and AppVeyor supported.')

    for recipe in recipes:
        os.chdir(recipe)
        # Configure
        [print(x, end="") for x in
         run_command(['cmake', '-H.', '-Bbuild', '-G' + generator])]
        os.chdir('build')
        # Build
        [print(x, end="") for x in
         run_command(['cmake', '--build', '.', '--', buildflags])]
        # Test
        # [print(x, end="") for x in run_command(['ctest'])]
        os.chdir(topdir)


if __name__ == '__main__':
    main()
