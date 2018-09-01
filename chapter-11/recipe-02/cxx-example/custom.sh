#!/usr/bin/env bash

set -eu -o pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# Remove symlinks if on CircleCI with Docker
if [ -n "${CIRCLECI_COMPILER+x}" ]; then
    script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    find "$script_dir" -type l -exec sh -c '
      file=$(basename "$1")
      directory=${1%/*}
      (cd "$directory" && cp --remove-destination "$(readlink "$file")" "$file")' sh {} ';'
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}"

cp ../account/test.py .

env PIPENV_MAX_DEPTH=1 pipenv install --three ..
pipenv run python test.py

exit $?
