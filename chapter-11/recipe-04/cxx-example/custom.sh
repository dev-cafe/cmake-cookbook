#!/usr/bin/env bash

#set -euxo pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}" || exit

echo 'Setting up files...'
cp -r ../conda-recipe .
cp ../CMakeLists.txt .
cp ../example.cpp .

if [[ "$OSTYPE" == "msys" ]]; then
    /c/deps/conda/scripts/conda.exe build conda-recipe

    /c/deps/conda/scripts/conda.exe install -y --use-local conda-example-simple

    echo "PREFIX IS ${PREFIX}"

    echo 'ls -ltrh /c/deps/conda/library/bin'
    ls -ltrh /c/deps/conda/library/bin

    echo '/c/deps/conda/library/bin/hello-conda.exe'
    /c/deps/conda/library/bin/hello-conda.exe
else
    PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

    conda build conda-recipe

    conda install --use-local conda-example-simple

    hello-conda
fi

exit $?
