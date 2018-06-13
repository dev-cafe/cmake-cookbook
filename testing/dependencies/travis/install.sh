#!/usr/bin/env bash

set -euxo pipefail

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  pip install --user pipenv --upgrade
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update &> /dev/null
  brew cask uninstall --force oclint
  brew uninstall --force --ignore-dependencies boost
  brew upgrade python
  brew install boost-python@1.59
  brew install boost@1.59
  brew install doxygen
  brew install gcc
  brew install mpich
  brew install ossp-uuid
  brew install pipenv
  brew install pkg-config
  brew install zeromq
  # Symlink the installed Boost.Python to where all the rest of Boost resides
  ln -sf /usr/local/opt/boost-python@1.59/lib/* /usr/local/opt/boost@1.59/lib
fi
