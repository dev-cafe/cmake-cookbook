#!/usr/bin/env bash

set -eu -o pipefail

echo "-- Installing Ninja"
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  Ninja_URL="https://github.com/Kitware/ninja/releases/download/v1.8.2.g3bbbe.kitware.dyndep-1.jobserver-1/ninja-1.8.2.g3bbbe.kitware.dyndep-1.jobserver-1_x86_64-linux-gnu.tar.gz"
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  Ninja_URL="https://github.com/Kitware/ninja/releases/download/v1.8.2.g3bbbe.kitware.dyndep-1.jobserver-1/ninja-1.8.2.g3bbbe.kitware.dyndep-1.jobserver-1_x86_64-apple-darwin.tar.gz"
fi
if [[ -f $HOME/Deps/ninja/ninja ]]; then
  echo "-- Ninja FOUND in cache"
else
  echo "-- Ninja NOT FOUND in cache"
  cd "$HOME"/Deps
  mkdir -p ninja
  curl -Ls $Ninja_URL | tar -xz -C ninja --strip-components=1
  cd "$TRAVIS_BUILD_DIR"
fi
echo "-- Done with Ninja"
