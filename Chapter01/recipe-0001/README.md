# Compiling a single source file into an executable

These recipes shows how to run CMake to configure and build a simple project. The project consists of a single source file for a single executable.
The same project is presented in C++, C and Fortran 90.

## Ingredients

- A C++ (or C or Fortran 90) compiler
- CMake, any version higher than 3.0

## Contents of `CMakeLists.txt`

All that’s needed to configure and build this minimal project on GNU/Linux, Mac OS X and Windows is the following:

```
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(recipe-0001 CXX)

add_executable(hello-world hello-world.cpp)
```

```
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
```
The first line sets a minimum required version for CMake. A fatal error will be issued if a version of CMake lower than that will be used.
```
project(recipe-0001 CXX)
```
The second line declares the name of the project, `recipe-0001`, and the project’s language.
C++ is the default programming language, but we suggest to always explicitly state the project’s language in the `project` command.
```
add_executable(hello-world hello-world.cpp)
```
Eventually, we instruct CMake to generate the executable named `hello-world` by compiling and linking the source file `hello-world.cpp`.
CMake will use default compiler and linker settings.

## Configure

Once in the directory containing the `CMakeLists.txt` file, simply run:
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
