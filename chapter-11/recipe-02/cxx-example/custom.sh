#!/usr/bin/env bash

set -eu -o pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# Remove symlinks
find "$PWD" -type l -exec sh -c '
    file=$(basename "$1")
    directory=${1%/*}
    (cd "$directory" && cp --remove-destination "$(readlink "$file")" "$file")' sh {} ';'

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}"

cp ../account/test.py .

env PIPENV_MAX_DEPTH=1 pipenv install ..
pipenv run python test.py

exit $?
