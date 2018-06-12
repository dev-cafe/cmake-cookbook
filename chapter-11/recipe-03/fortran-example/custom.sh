#!/usr/bin/env bash

set -euxo pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}"

ls -l ..
cp ../account/test.py .

PIPENV_MAX_DEPTH=1 pipenv install ..
pipenv run python test.py

exit $?
