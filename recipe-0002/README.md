Switching Generators
====================

A single `CMakeLists.txt` can be used to configure projects for different toolstacks on different platforms.
CMake is a build system _generator_. starting from a description of the operations the build system, _e.g._ Unix Makefiles, Ninja, Visual Studio, etc.,
will have to run to get your code compiled, CMake _generates_ the corresponding instructions for the chosen build system.

CMake supports an [extensive list]() of native build tools for the different platforms. It is possible to get a list of
the available ones for the currently installed version of CMake on the current platform by running:
```
cmake --help
```
This recipe builds upon [recipe-0001](../recipe-0001/README.md) to show how to achieve this on GNU/Linux, Mac OS X and Windows.

## Ingredients

- A C++ compiler.
- CMake, any version higher than 2.8.
- A GNU/Linux system with `make` and Ninja installed.
- A Mac OS X system with `make` and Ninja installed.
- A Windows system with Visual Studio, MinGW and Ninja installed.

## Configure

The default generators are:
- Unix Makefiles on GNU/Linux
- Unix Makefiles on Mac OS X
- FIXME on Windows
```
cmake .
```
CMake will output a series of status messages informing you on the configuration:[^1]
```
-- The CXX compiler identification is GNU 5.4.0
-- Check for working CXX compiler: /home/roberto/.nix-profile/bin/c++
-- Check for working CXX compiler: /home/roberto/.nix-profile/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/roberto/Workspace/robertodr/cmake-recipes/recipe-0001
```
Notice that CMake wrote all the files it generated at the **root** of the project. This is an _in-source build_ and is generally undesirable,
as it mixes the source and the build tree of the project. Fortunately, it is very easy to instruct CMake to generate its files for
an _out-of-source_ build:
```
cmake -H. -Bbuild
```
will configure the project and save the generated files in the `build` directory.
CMake has additional mechanism to ensure that a build is out-of-source, see [recipe-XYZU](recipe-XYZU/README.md)

### What kind of configuration was generated?

CMake is a build system _generator_. You describe what type of operations the build system, _e.g._ Unix Makefiles, Ninja, Visual Studio, etc.,
will have to run to get your code compiled. In turn, CMake _generates_ the corresponding instructions for the chosen build system.
By default, on GNU/Linux and Mac OS X systems, CMake employs the Unix Makefiles generator. On Windows, _what is used by default on Windows?_

On GNU/Linux, CMake will by default generate Unix Makefiles to build the project:
- `Makefile`. The set of instructions that `make` will run to build the project.
- `CMakeFiles/`. Contains temporary files, used by CMake for detecting the OS, compiler, etc.
   In addition, depending on the chosen _generator_ it also contains project-specific files.
- `cmake_install.cmake`. _What is this?_
- `CMakeCache.txt`. The CMake cache, as the file name suggests. This file is used by CMake when re-running the configuration.

## Build

We can now build by running:
```
cmake --build .
```
which wraps the native build command for the chosen _generator_ (`make`, in this case).
The corresponding build output to screen:
```
Scanning dependencies of target hello-world
[ 50%] Building CXX object CMakeFiles/hello-world.dir/hello-world.cpp.o
[100%] Linking CXX executable hello-world
[100%] Built target hello-world
```

[^1] This output was obtained with CMake version 3.7.2
