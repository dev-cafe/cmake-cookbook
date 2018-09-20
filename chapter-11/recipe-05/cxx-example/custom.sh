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
    echo "conda.exe build --no-anaconda-upload conda-recipe"
    conda.exe build --no-anaconda-upload conda-recipe

    echo "conda.exe install --no-update-dependencies --use-local --yes conda-example-dgemm"
    conda.exe install --no-update-dependencies --use-local --yes conda-example-dgemm

    echo "dgemm-example.exe"
    dgemm-example.exe

    echo "conda.exe clean --all --yes"
    conda.exe clean --all --yes
else
    PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

    conda clean --all --yes

    conda build conda-recipe

    conda install --no-update-deps --use-local --yes conda-example-dgemm

    dgemm-example

    conda clean --all --yes
fi

exit $?
