let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-18.03";
    sha256 = "1q32p61l2y8wcrc8q01k364xsmfpfygbxawwkby3dh199zyhwl6r";
  });
in
  with import nixpkgs {
    overlays = [(self: super:
    {
      ninja-kitware = super.callPackage ./.pkgs/ninja-kitware.nix {};
    }
    )];
  };
  stdenv.mkDerivation {
    name = "CMake-recipes";
    buildInputs = [
      atlas
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
      hdf5-fortran
      lcov
      libuuid
      mercurial
      ninja-kitware
      openblas
      openmpi
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
      zeromq
      zlib
    ];
    hardeningDisable = [ "all" ];
    src = null;
    shellHook = ''
    export NINJA_STATUS="[Built edge %f of %t in %e sec]"
    SOURCE_DATE_EPOCH=$(date +%s)
    '';
  }
