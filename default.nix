let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-17.09";
    sha256 = "0x7n6mz0gxvvjwshwdlfi1ypd84z9v9s3qpkixgjhzr1lx6q94ag";
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
      atlas
      boost
      ccache
      clang-tools
      cmake_3_10
      doxygen
      exa
      eigen3_3
      gcc
      gfortran
      hdf5
      liblapack
      libuuid
      ninja-kitware
      openmpi
      python3Packages.colorama
      python3Packages.docopt
      python3Packages.matplotlib
      python3Packages.numpy
      python3Packages.pycodestyle
      python3Packages.pycodestyle
      python3Packages.pyyaml
      python3Packages.virtualenvwrapper
      valgrind
      zlib
    ];
  }
