let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-unstable";
    sha256 = "1i3p5m0pnn86lzni5y1win0sacckw3wlg9kqaw15nszhykgz22zq";
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
      blas
      liblapack
      libuuid
      ninja
      openmpi
      python36Packages.matplotlib
      python36Packages.numpy
      python36Packages.pyyaml
      python36Packages.virtualenvwrapper
      valgrind
      zlib
    ];
  }
