let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-unstable";
    sha256 = "1icphqpdcl8akqhfij2pxkfr7wfn86z5sr3jdjh88p9vv1550dx7";
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
      boost
      ccache
      clang-tools
      cmake_3_10
      doxygen
      eigen3_3
      exa
      gcc
      gfortran
      hdf5
      liblapack
      libuuid
      ninja-kitware
      openmpi
      python3Full
      python3Packages.cffi
      python3Packages.colorama
      python3Packages.cython
      python3Packages.docopt
      python3Packages.numpy
      python3Packages.pycodestyle
      python3Packages.pyyaml
      valgrind
      zlib
    ];
    src = null;
    shellHook = ''
      NINJA_STATUS="[Built edge %f of %t in %e sec]"
      SOURCE_DATE_EPOCH=$(date +%s)
    '';
  }
