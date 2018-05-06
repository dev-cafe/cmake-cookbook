#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  pip install --user pipenv --upgrade
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update &> /dev/null
  brew cask uninstall --force oclint
  brew uninstall --force --ignore-dependencies boost
  brew upgrade python
  brew install pipenv
  brew install gcc
  brew install mpich
  brew install pkg-config
  brew install ossp-uuid
  brew install doxygen
  brew install boost@1.59
  brew install boost-python@1.59
  # Symlink the installed Boost.Python to where all the rest of Boost resides
  ln -sf /usr/local/opt/boost-python@1.59/lib/* /usr/local/opt/boost@1.59/lib
fi

echo "-- Installing CMake"
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  if [[ -f $HOME/Deps/cmake/$CMAKE_VERSION/bin/cmake ]]; then
    echo "-- CMake $CMAKE_VERSION FOUND in cache"
  else
    echo "-- CMake $CMAKE_VERSION NOT FOUND in cache"
    target_path=$HOME/Deps/cmake/$CMAKE_VERSION
    cmake_url="https://cmake.org/files/v${CMAKE_VERSION%.*}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz"
    mkdir -p $target_path
    curl -Ls $cmake_url | tar -xz -C $target_path --strip-components=1
  fi
elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew upgrade cmake
fi
echo "-- Done installing CMake"

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
  cd $HOME/Deps
  mkdir -p ninja
  curl -Ls $Ninja_URL | tar -xz -C ninja --strip-components=1
  cd $TRAVIS_BUILD_DIR
fi
echo "-- Done with Ninja"

Eigen_VERSION="3.3.4"
echo "-- Installing Eigen $Eigen_VERSION"
if [[ -f $HOME/Deps/eigen/include/eigen3/signature_of_eigen3_matrix_library ]]; then
  echo "-- Eigen $Eigen_VERSION FOUND in cache"
else
  echo "-- Eigen $Eigen_VERSION NOT FOUND in cache"
  cd $HOME/Downloads
  mkdir -p eigen
  curl -Ls http://bitbucket.org/eigen/eigen/get/${Eigen_VERSION}.tar.gz | tar -xz -C eigen --strip-components=1
  cd eigen
  cmake -H. -Bbuild_eigen -DCMAKE_INSTALL_PREFIX=$HOME/Deps/eigen &> /dev/null
  cmake --build build_eigen -- install &> /dev/null
  cd $TRAVIS_BUILD_DIR
  rm -rf $HOME/Downloads/eigen
fi
echo "-- Done with Eigen $Eigen_VERSION"

Anaconda_VERSION="5.1.0"
echo "-- Installing Anaconda $Anaconda_VERSION"
if [[ -d "$HOME/Deps/conda/bin" ]]; then
  echo "-- Anaconda $Anaconda_VERSION FOUND in cache"
else
  cd $HOME/Downloads
  echo "-- Anaconda $Anaconda_VERSION NOT FOUND in cache"
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    curl -Ls https://repo.continuum.io/archive/Anaconda2-${Anaconda_VERSION}-Linux-x86_64.sh > conda.sh
  elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    curl -Ls https://repo.continuum.io/archive/Anaconda3-${Anaconda_VERSION}-MacOSX-x86_64.sh > conda.sh
  fi
  # Travis creates the cached directories for us.
  # This is problematic when wanting to install Anaconda for the first time...
  rm -rf $HOME/Deps/conda
  bash conda.sh -b -p $HOME/Deps/conda
  PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  cd $TRAVIS_BUILD_DIR
  rm -f $HOME/Downloads/conda.sh
fi
echo "-- Done with Anaconda $Anaconda_VERSION"
