let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "ac355040656de04f59406ba2380a96f4124ebdad";
    sha256 = "0frhc7mnx88sird6ipp6578k5badibsl0jfa22ab9w6qrb88j825";
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
      ninja = super.callPackage ./.pkgs/ninja-kitware.nix {};
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
      python35Packages.matplotlib
      python35Packages.numpy
      python35Packages.pyyaml
      python35Packages.virtualenvwrapper
      valgrind
      zlib
    ];
  }
