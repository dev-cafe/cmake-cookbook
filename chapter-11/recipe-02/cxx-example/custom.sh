#!/usr/bin/env bash

# It's turtles all the way down

set -eu -o pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd $build_directory

# we tar with --dereference and then untar to get rid of symlinks
tar --exclude "build-*" --dereference --directory "${script_directory}" -c -f - . | tar -x

# Now make a directory where we test the
# install in a virtual environment
mkdir -p venv
mv account/test.py venv

cd venv
export PIPENV_MAX_DEPTH=1
export PIPENV_IGNORE_VIRTUALENVS=1
export PIPENV_VERBOSITY=-1
pipenv install --three ..
pipenv run python test.py
pipenv --rm

exit $?
