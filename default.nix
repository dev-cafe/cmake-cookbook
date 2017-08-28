with import <nixpkgs> {}; {
  cmakeEnv = stdenv.mkDerivation {
    name = "cmake-recipes";
    buildInputs = [
      boost
      bundler
      ccache
      clang
      clang-tools
      clang-analyzer
      cmake
      doxygen
      gcc
      gfortran
      gdb
      lldb
      openmpi
      python27Packages.breathe
      python27Packages.jupyter
      python27Packages.matplotlib
      python27Packages.numpy
      python27Packages.pyyaml
      python27Packages.scipy
      python27Packages.sphinx
      python27Packages.sympy
      zlib
    ];
  };
}
