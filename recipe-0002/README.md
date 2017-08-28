Switching Generators
====================

A single `CMakeLists.txt` can be used to configure projects for different toolstacks on different platforms.
CMake is a build system _generator_. starting from a description of the operations the build system, _e.g._ Unix Makefiles, Ninja, Visual Studio, etc.,
will have to run to get your code compiled, CMake _generates_ the corresponding instructions for the chosen build system.

CMake supports an [extensive list](https://cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html) of native build tools for the different platforms. It is possible to get a list of
the available ones for the currently installed version of CMake on the current platform by running:
```
cmake --help
```
This recipe builds upon [recipe-0001](../recipe-0001/README.md) to show how to achieve this on GNU/Linux, Mac OS X and Windows.

## Ingredients

- A C++ compiler.
- CMake, any version higher than 3.0.
- A GNU/Linux system with `make` and Ninja installed.
- A Mac OS X system with `make` and Ninja installed.
- A Windows system with Visual Studio, MinGW and Ninja installed.

## Configure

The default generators are:
- Unix Makefiles on GNU/Linux
- Unix Makefiles on Mac OS X
- FIXME on Windows
```
cmake -H. -Bbuild -GNinja
```
