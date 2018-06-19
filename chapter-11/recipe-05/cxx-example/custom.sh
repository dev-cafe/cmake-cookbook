#!/usr/bin/env bash

set -eu -o pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}" || exit

cp -r ../conda-recipe .
cp ../CMakeLists.txt .
cp ../example.cpp .

if [[ "$OSTYPE" == "msys" ]]; then
    /c/deps/conda/scripts/conda.exe config --show

    /c/deps/conda/scripts/conda.exe build conda-recipe

    /c/deps/conda/scripts/conda.exe install -y --use-local conda-example-dgemm

    /c/deps/conda/library/bin/dgemm-example.exe
else
    PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

    ls "$HOME"/Deps/conda/bin

    conda config --show

    conda build conda-recipe

    conda install --use-local conda-example-dgemm

    dgemm-example
fi

exit $?
