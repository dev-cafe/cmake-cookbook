#!/usr/bin/env bash

set -eu -o pipefail

Eigen_VERSION="3.3.4"
echo "-- Installing Eigen $Eigen_VERSION"
if [[ -f $HOME/Deps/eigen/include/eigen3/signature_of_eigen3_matrix_library ]]; then
  echo "-- Eigen $Eigen_VERSION FOUND in cache"
else
  echo "-- Eigen $Eigen_VERSION NOT FOUND in cache"
  cd "$HOME"/Downloads
  mkdir -p eigen
  curl -Ls http://bitbucket.org/eigen/eigen/get/${Eigen_VERSION}.tar.gz | tar -xz -C eigen --strip-components=1
  cd eigen
  cmake -H. -Bbuild_eigen -DCMAKE_INSTALL_PREFIX="$HOME"/Deps/eigen &> /dev/null
  cmake --build build_eigen -- install &> /dev/null
  cd "$TRAVIS_BUILD_DIR"
  rm -rf "$HOME"/Downloads/eigen
fi
echo "-- Done with Eigen $Eigen_VERSION"
