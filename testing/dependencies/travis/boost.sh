#!/usr/bin/env bash

set -eu -o pipefail

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    Boost_VERSION="1.59.0"
    echo "-- Installing Boost $Boost_VERSION"
    if [[ -f "$HOME/Deps/boost_${Boost_VERSION}/include/boost/version.hpp" ]]; then
        echo "-- Boost $Boost_VERSION FOUND in cache"
    else
        echo "-- Boost $Boost_VERSION NOT FOUND in cache"
        target_path=$HOME/Downloads/boost_"${Boost_VERSION//\./_}"
        boost_url="https://sourceforge.net/projects/boost/files/boost/$Boost_VERSION/boost_${Boost_VERSION//\./_}.tar.gz"
        mkdir -p "$target_path"
        curl -Ls "$boost_url" | tar -xz -C "$target_path" --strip-components=1
        cd "$target_path"
        # Configure
        ./bootstrap.sh \
            --with-toolset=gcc \
            --with-libraries=filesystem,system,test,python \
            --with-python="$PYTHON3" \
            --prefix="$HOME/Deps/boost_${Boost_VERSION}" &> /dev/null
        # Build and install
        ./b2 -q install \
             link=shared \
             threading=multi \
             variant=release \
             toolset=gcc-7 \
             --with-filesystem \
             --with-test \
             --with-system \
             --with-python &> /dev/null
    fi
    echo "-- Done installing Boost $Boost_VERSION"
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    brew install boost
    brew install boost-python3
fi
