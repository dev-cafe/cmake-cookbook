#!/usr/bin/env bash

set -euo pipefail

Ninja_URL=""
# OS-dependent operations
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  CMake_VERSION="3.10.0"
  echo "-- Installing CMake $CMake_VERSION"
  if [[ -f $HOME/Deps/cmake/bin/cmake ]]; then
    echo "-- CMake $CMake_VERSION FOUND in cache"
  else
    echo "-- CMake $CMake_VERSION NOT FOUND in cache"
    cd $HOME/Deps
    mkdir -p cmake
    curl -Ls https://cmake.org/files/v${CMake_VERSION%.*}/cmake-${CMake_VERSION}-Linux-x86_64.tar.gz | tar -xz -C cmake --strip-components=1
    cd $TRAVIS_BUILD_DIR
  fi
  echo "-- Done with CMake $CMake_VERSION"
  Ninja_URL="https://goo.gl/4g5Jjv"
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update &> /dev/null
  brew cask uninstall --force oclint boost
  brew install gcc@7 mpich pkg-config ossp-uuid
  brew upgrade cmake
  brew install boost@1.62 --with-python
  brew install boost-python@1.62
  brew install pyenv-virtualenv
  Ninja_URL="https://goo.gl/qLgScp"
fi

echo "-- Installing Ninja"
if [[ -f $HOME/Deps/ninja/ninja ]]; then
  echo "-- Ninja FOUND in cache"
else
  echo "-- Ninja NOT FOUND in cache"
  cd $HOME/Deps
  mkdir -p ninja
  curl -Ls $Ninja_URL | tar -xz -C ninja --strip-components=1
  cd $TRAVIS_BUILD_DIR
fi
echo "-- Done with Ninja"

cd $HOME/Downloads

Eigen_VERSION="3.3.4"
echo "-- Installing Eigen $Eigen_VERSION"
if [[ -f $HOME/Deps/eigen/include/eigen3/signature_of_eigen3_matrix_library ]]; then
  echo "-- Eigen $Eigen_VERSION FOUND in cache"
else
  echo "-- Eigen $Eigen_VERSION NOT FOUND in cache"
  curl -Ls http://bitbucket.org/eigen/eigen/get/3.3.4.tar.gz | tar -xz
  cd eigen-eigen-5a0156e40feb
  cmake -H. -Bbuild_eigen -DCMAKE_INSTALL_PREFIX=$HOME/Deps/eigen &> /dev/null
  cmake --build build_eigen -- install &> /dev/null
  cd $HOME/Downloads
fi
echo "-- Done with Eigen $Eigen_VERSION"

HDF5_VERSION="1.10.1"
echo "-- Installing HDF5 $HDF5_VERSION"
HDF5_URL="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5_VERSION%.*}/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.bz2"
if [[ -f $HOME/Deps/hdf5/lib/libhdf5_fortran.so ]]; then
  echo "-- HDF5 $HDF5_VERSION FOUND in cache"
else
  echo "-- HDF5 $HDF5_VERSION NOT FOUND in cache"
  curl -Ls $HDF5_URL | tar -xj
  cd hdf5-$HDF5_VERSION
  CC=mpicc FC=mpif90 CXX=mpic++ ./configure --prefix=$HOME/Deps/hdf5 --enable-build-mode=debug \
              --enable-fortran --enable-parallel &> /dev/null
  make install --jobs=2 &> /dev/null
  cd $HOME/Downloads
fi
echo "-- Done with HDF5 $HDF5_VERSION"

cd $TRAVIS_BUILD_DIR
