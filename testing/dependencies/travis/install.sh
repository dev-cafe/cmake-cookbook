#!/usr/bin/env bash

set -eu -o pipefail

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  pip install --user pipenv --upgrade
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update &> /dev/null
  brew cask uninstall --force oclint
  brew uninstall --force --ignore-dependencies boost
  brew upgrade python
  brew install doxygen
  brew install gcc
  brew install mingw-w64
  brew install mpich
  brew install ossp-uuid
  brew install pipenv
  brew install pkg-config
  brew install zeromq
fi
