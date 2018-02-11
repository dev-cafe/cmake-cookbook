let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-unstable";
    sha256 = "1zcbvzxk1vyk4ngfdyss8mlb3mqp050ygpnwqny0bxbzlqkrc4bh";
  });
in
  with import nixpkgs {
    overlays = [(self: super:
    {
      cmake_3_10 = super.libsForQt5.callPackage ./.pkgs/cmake_3_10.nix {
        inherit (self.darwin) ps;
      };
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
      cmake_3_10
      doxygen
      eigen3_3
      exa
      gcc
      gfortran
      gfortran.cc.lib
      hdf5
      liblapack
      libuuid
      ninja-kitware
      openmpi
      pipenv
      pkgconfig
      python3Full
      python3Packages.cffi
      python3Packages.colorama
      python3Packages.cython
      python3Packages.docopt
      python3Packages.numpy
      python3Packages.pycodestyle
      python3Packages.pyyaml
      stdenv
      valgrind
      zlib
    ];
    src = null;
    shellHook = ''
    export NINJA_STATUS="[Built edge %f of %t in %e sec]"
    SOURCE_DATE_EPOCH=$(date +%s)
    '';
  }
