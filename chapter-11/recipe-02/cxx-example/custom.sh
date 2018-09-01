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

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
testing_dir="$script_dir/../../../testing"

# shellcheck source=/dev/null
. "${testing_dir}/canonicalize_filename.sh"

# Copy stuff to build_directory, removing symlinks in the process
for f in $script_dir/CMakeLists.txt $script_dir/MANIFEST.in $script_dir/setup.py $script_dir/README.rst; do
    canonical="$(canonicalize_filename "$f")"
    cp -f "$canonical" "$build_directory"
done
# Copying for account is done separately
mkdir -p "${build_directory}"/account
for f in $script_dir/account/*; do
    canonical="$(canonicalize_filename "$f")"
    cp -f "$canonical" "$build_directory"/account
done

cd "${build_directory}"
# Now make a directory where we test the
# install in a virtual environment
mkdir -p venv
mv account/test.py venv

cd venv
export PIPENV_MAX_DEPTH=1
pipenv install --three ..
pipenv run python test.py
pipenv --rm

exit $?
