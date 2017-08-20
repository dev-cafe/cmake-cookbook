# recipe-0000

- Discuss how to install CMake.
- Discuss generators. Specifically the ones that will actually be used on the
  CI services: Unix Makefiles, Ninja, Visual Studio, MinGW Makefiles.
  [cmake-generators](https://cmake.org/cmake/help/v3.7/manual/cmake-generators.7.html#manual:cmake-generators(7))
- Source files:
  - C++11
  - C99
  - Fortran90
- Explain set up used on Travis and AppVeyor:
  - CMake at least 3.7.2
  - Ninja version [maintained by Kitware](https://github.com/Kitware/ninja)
