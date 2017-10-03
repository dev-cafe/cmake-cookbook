with import <nixpkgs> {}; {
  cmakeEnv = stdenv.mkDerivation {
    name = "cmake-recipes";
    buildInputs = [
      atlasWithLapack
      boost
      bundler
      ccache
      clang
      clang-tools
      clang-analyzer
      cmake
      doxygen
      eigen3_3
      gcc
      gfortran
      gdb
      hdf5-fortran
      libuuid
      lldb
      openmpi
      python35Packages.breathe
      python35Packages.jupyter
      python35Packages.matplotlib
      python35Packages.numpy
      python35Packages.pyyaml
      python35Packages.scipy
      python35Packages.sphinx
      python35Packages.sympy
      zlib
    ];
  };
}
