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
    echo "conda.exe clean --all"
    conda.exe clean --all

    echo "conda.exe build conda-recipe"
    conda.exe build conda-recipe

    echo "conda.exe install --use-local conda-example-dgemm"
    conda.exe install --use-local conda-example-dgemm

    echo "dgemm-example.exe"
    dgemm-example.exe
else
    PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

    conda clean --all

    conda build conda-recipe

    conda install --use-local conda-example-dgemm

    dgemm-example
fi

exit $?
