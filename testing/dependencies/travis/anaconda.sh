#!/usr/bin/env bash

set -eu -o pipefail

Anaconda_VERSION="5.2.0"
echo "-- Installing Anaconda $Anaconda_VERSION"
if [[ -d "$HOME/Deps/conda/bin" ]]; then
  echo "-- Anaconda $Anaconda_VERSION FOUND in cache"
else
  cd "$HOME"/Downloads
  echo "-- Anaconda $Anaconda_VERSION NOT FOUND in cache"
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    curl -Ls https://repo.continuum.io/archive/Anaconda3-${Anaconda_VERSION}-Linux-x86_64.sh > conda.sh
  elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    curl -Ls https://repo.continuum.io/archive/Anaconda3-${Anaconda_VERSION}-MacOSX-x86_64.sh > conda.sh
  fi
  # Travis creates the cached directories for us.
  # This is problematic when wanting to install Anaconda for the first time...
  rm -rf "$HOME"/Deps/conda
  bash conda.sh -b -p "$HOME"/Deps/conda
  PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  cd "$TRAVIS_BUILD_DIR"
  rm -f "$HOME"/Downloads/conda.sh
fi
echo "-- Done with Anaconda $Anaconda_VERSION"
