#!/usr/bin/env bash

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}" || exit

PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

conda create -q --name test-environment-simple
source activate test-environment-simple

cp -r ../conda-recipe .
cp ../CMakeLists.txt .
cp ../example.cpp .

conda build conda-recipe
conda install --use-local conda-example-simple

hello-conda

exit $?
