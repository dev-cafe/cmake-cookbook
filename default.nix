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
      atlas = super.atlas.override {
        withLapack = true;
      };
      hdf5 = super.hdf5.override {
        gfortran = super.gfortran;
        mpi = super.openmpi;
      };
    }
    )];
  };
  stdenv.mkDerivation {
    name = "CMake-recipes";
    buildInputs = [
      atlas
      boost
      ccache
      clang
      clang-tools
      clang-analyzer
      cmake
      doxygen
      exa
      eigen3_3
      gcc
      gfortran
      hdf5
      libuuid
      openmpi
      python35Packages.matplotlib
      python35Packages.numpy
      python35Packages.pyyaml
      valgrind
      zlib
    ];
  }
