#!/usr/bin/env bash

set -eu -o pipefail

echo "-- Installing latest Miniconda"
if [[ -d "$HOME/Deps/conda/bin" ]]; then
    echo "-- Miniconda latest version FOUND in cache"
else
    cd "$HOME"/Downloads
    echo "-- Miniconda latest version NOT FOUND in cache"
    if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
        curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda.sh
    elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
        curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > miniconda.sh
    fi
    # Travis creates the cached directories for us.
    # This is problematic when wanting to install Anaconda for the first time...
    rm -rf "$HOME"/Deps/conda
    bash miniconda.sh -b -p "$HOME"/Deps/conda &> /dev/null
    touch "$HOME"/Deps/conda/conda-meta/pinned
    PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}
    conda config --set show_channel_urls True &> /dev/null
    conda config --set always_yes yes &> /dev/null
    conda config --set changeps1 no &> /dev/null
    conda update --all --yes &> /dev/null
    conda clean -tipy &> /dev/null
    # Install conda build and deployment tools.
    conda install --yes --quiet conda-build anaconda-client conda-verify jinja2 setuptools &> /dev/null
    conda clean -tipsy &> /dev/null
    conda info -a
    cd "$TRAVIS_BUILD_DIR"
    rm -f "$HOME"/Downloads/miniconda.sh
fi
echo "-- Done with latest Miniconda"
