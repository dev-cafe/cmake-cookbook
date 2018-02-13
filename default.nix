let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-unstable";
    sha256 = "1ig27lcx533jjdxg9f7wj7n9bwkd12yj5zpzkn4qx60kpbvla27c";
  });
in
  with import nixpkgs {
    overlays = [(self: super:
    {
      hdf5 = super.hdf5.override {
        gfortran = self.gfortran;
        mpi = self.openmpi;
      };
      ninja-kitware = super.callPackage ./.pkgs/ninja-kitware.nix {};
    }
    )];
  };
  stdenv.mkDerivation {
    name = "CMake-recipes";
    buildInputs = [
      boost155
      ccache
      clang-tools
      cmake
      dpkg
      doxygen_gui
      eigen3_3
      exa
      gcc
      gfortran
      gfortran.cc.lib
      graphviz
      hdf5
      lcov
      liblapack
      libuuid
      ninja-kitware
      openmpi
      pipenv
      pkgconfig
      python3Full
      python3Packages.breathe
      python3Packages.cffi
      python3Packages.colorama
      python3Packages.cython
      python3Packages.docopt
      python3Packages.numpy
      python3Packages.pycodestyle
      python3Packages.pyyaml
      python3Packages.sphinx
      rpm
      valgrind
      zlib
    ];
    src = null;
    shellHook = ''
    export NINJA_STATUS="[Built edge %f of %t in %e sec]"
    SOURCE_DATE_EPOCH=$(date +%s)
    '';
  }
