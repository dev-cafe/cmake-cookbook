
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/dev-cafe/cmake-cookbook/master/LICENSE)

[![Travis](https://travis-ci.org/dev-cafe/cmake-cookbook.svg?branch=master)](https://travis-ci.org/dev-cafe/cmake-cookbook)
[![AppVeyor](https://ci.appveyor.com/api/projects/status/fvmidu9lcqvy52g8?svg=true)](https://ci.appveyor.com/project/bast/cmake-cookbook)
[![CircleCI](https://circleci.com/gh/dev-cafe/cmake-cookbook.svg?style=svg)](https://circleci.com/gh/dev-cafe/cmake-cookbook)

[![GitHub issues](https://img.shields.io/github/issues/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/issues)
[![GitHub forks](https://img.shields.io/github/forks/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/network)
[![GitHub stars](https://img.shields.io/github/stars/dev-cafe/cmake-cookbook.svg?style=flat-square)](https://github.com/dev-cafe/cmake-cookbook/stargazers)


# CMake Cookbook

This repository collects sources for the recipes contained in the
[CMake Cookbook](https://www.packtpub.com/application-development/cmake-cookbook)
published by Packt and authored by [Radovan Bast](https://github.com/bast) and
[Roberto Di Remigio](https://github.com/robertodr)

- [Contributing](.github/CONTRIBUTING.md)
- [Testing](testing/README.md)


## Table of contents



### [Chapter 1: From a Simple Executable to Libraries](chapter-01/README.md)

- [1. Compiling a single source file into an executable](chapter-01/recipe-01/README.md)
- [2. Switching generators](chapter-01/recipe-02/README.md)
- [3. Building and linking static and shared libraries](chapter-01/recipe-03/README.md)
- [4. Controlling compilation with conditionals](chapter-01/recipe-04/README.md)
- [5. Presenting options to the user](chapter-01/recipe-05/README.md)
- [6. Specifying the compiler](chapter-01/recipe-06/README.md)
- [7. Switching the build type](chapter-01/recipe-07/README.md)
- [8. Controlling compiler flags](chapter-01/recipe-08/README.md)
- [9. Setting the standard for the language](chapter-01/recipe-09/README.md)
- [10. Using control flow constructs](chapter-01/recipe-10/README.md)


### [Chapter 2: Detecting the Environment](chapter-02/README.md)

- [1. Discovering the operating system](chapter-02/recipe-01/README.md)
- [2. Dealing with platform-dependent source code](chapter-02/recipe-02/README.md)
- [3. Dealing with compiler-dependent source code](chapter-02/recipe-03/README.md)
- [4. Discovering the host processor architecture](chapter-02/recipe-04/README.md)
- [5. Discovering the host processor instruction set](chapter-02/recipe-05/README.md)
- [6. Enabling vectorization for the Eigen library](chapter-02/recipe-06/README.md)


### [Chapter 3: Detecting External Libraries and Programs](chapter-03/README.md)

- [1. Detecting the Python interpreter](chapter-03/recipe-01/README.md)
- [2. Detecting the Python library](chapter-03/recipe-02/README.md)
- [3. Detecting Python modules and packages](chapter-03/recipe-03/README.md)
- [4. Detecting the BLAS and LAPACK math libraries](chapter-03/recipe-04/README.md)
- [5. Detecting the OpenMP parallel environment](chapter-03/recipe-05/README.md)
- [6. Detecting the MPI parallel environment](chapter-03/recipe-06/README.md)
- [7. Detecting the Eigen library](chapter-03/recipe-07/README.md)
- [8. Detecting the Boost libraries](chapter-03/recipe-08/README.md)
- [9. Detecting external libraries: I. Using `pkg-config`](chapter-03/recipe-09/README.md)
- [10. Detecting external libraries: II. Writing a find-module](chapter-03/recipe-10/README.md)


### [Chapter 4: Creating and Running Tests](chapter-04/README.md)

- [1. Creating a simple unit test](chapter-04/recipe-01/README.md)
- [2. Defining a unit test using the Catch2 library](chapter-04/recipe-02/README.md)
- [3. Defining a unit test and linking against Google Test](chapter-04/recipe-03/README.md)
- [4. Defining a unit test and linking against Boost test](chapter-04/recipe-04/README.md)
- [5. Using dynamic analysis to detect memory defects](chapter-04/recipe-05/README.md)
- [6. Testing expected failures](chapter-04/recipe-06/README.md)
- [7. Using timeouts for long tests](chapter-04/recipe-07/README.md)
- [8. Running tests in parallel](chapter-04/recipe-08/README.md)
- [9. Running a subset of tests](chapter-04/recipe-09/README.md)
- [10. Using test fixtures](chapter-04/recipe-10/README.md)


### [Chapter 5: Configure-time and Build-time Operations](chapter-05/README.md)

- [1. Using platform-independent file operations](chapter-05/recipe-01/README.md)
- [2. Running a custom command at configure time](chapter-05/recipe-02/README.md)
- [3. Running a custom command at build time: I. Using `add_custom_command`](chapter-05/recipe-03/README.md)
- [4. Running a custom command at build time: II. Using `add_custom_target`](chapter-05/recipe-04/README.md)
- [5. Running custom commands for specific targets at build time](chapter-05/recipe-05/README.md)
- [6. Probing compilation and linking](chapter-05/recipe-06/README.md)
- [7. Probing compiler flags](chapter-05/recipe-07/README.md)
- [8. Probing execution](chapter-05/recipe-08/README.md)
- [9. Fine-tuning configuration and compilation with generator expressions](chapter-05/recipe-09/README.md)


### [Chapter 6: Generating Source Code](chapter-06/README.md)

- [1. Generating sources at configure time](chapter-06/recipe-01/README.md)
- [2. Generating source code at configure time using Python](chapter-06/recipe-02/README.md)
- [3. Generating source code at build time using Python](chapter-06/recipe-03/README.md)
- [4. Recording the project version information for reproducibility](chapter-06/recipe-04/README.md)
- [5. Recording the project version from a file](chapter-06/recipe-05/README.md)
- [6. Recording the Git hash at configure time](chapter-06/recipe-06/README.md)
- [7. Recording the Git hash at build time](chapter-06/recipe-07/README.md)


### [Chapter 7: Structuring Projects](chapter-07/README.md)

- [1. Code reuse with functions and macros](chapter-07/recipe-01/README.md)
- [2. Splitting CMake sources into modules](chapter-07/recipe-02/README.md)
- [3. Writing a function to test and set compiler flags](chapter-07/recipe-03/README.md)
- [4. Defining a function or macro with named arguments](chapter-07/recipe-04/README.md)
- [5. Redefining functions and macros](chapter-07/recipe-05/README.md)
- [6. Deprecating functions, macros, and variables](chapter-07/recipe-06/README.md)
- [7. Limiting scope with `add_subdirectory`](chapter-07/recipe-07/README.md)
- [8. Avoiding global variables using `target_sources`](chapter-07/recipe-08/README.md)
- [9. Organizing Fortran projects](chapter-07/recipe-09/README.md)


### [Chapter 8: The Superbuild Pattern](chapter-08/README.md)

- [1. Using the superbuild pattern](chapter-08/recipe-01/README.md)
- [2. Managing dependencies with a superbuild: I. The Boost libraries](chapter-08/recipe-02/README.md)
- [3. Managing dependencies with a superbuild: II. The FFTW library](chapter-08/recipe-03/README.md)
- [4. Managing dependencies with a superbuild: III. The Google Test framework](chapter-08/recipe-04/README.md)
- [5. Managing your project as a superbuild](chapter-08/recipe-05/README.md)


### [Chapter 9: Mixed-language Projects](chapter-09/README.md)

- [1. Building Fortran projects that use C/C++ libraries](chapter-09/recipe-01/README.md)
- [2. Building C/C++ projects that use Fortran libraries](chapter-09/recipe-02/README.md)
- [3. Building C++ and Python projects using Cython](chapter-09/recipe-03/README.md)
- [4. Building C++ and Python projects using Boost.Python](chapter-09/recipe-04/README.md)
- [5. Building C++ and Python projects using pybind11](chapter-09/recipe-05/README.md)
- [6. Mixing C, C++, Fortran, and Python using Python CFFI](chapter-09/recipe-06/README.md)


### [Chapter 10: Writing an Installer](chapter-10/README.md)

- [1. Installing your project](chapter-10/recipe-01/README.md)
- [2. Generating export headers](chapter-10/recipe-02/README.md)
- [3. Exporting your targets](chapter-10/recipe-03/README.md)
- [4. Installing a superbuild](chapter-10/recipe-04/README.md)


### [Chapter 11: Packaging Projects](chapter-11/README.md)

- [1. Generating source and binary packages](chapter-11/recipe-01/README.md)
- [2. Distributing a C++/Python project built with CMake/pybind11 via PyPI](chapter-11/recipe-02/README.md)
- [3. Distributing a C/Fortran/Python project built with CMake/CFFI via PyPI](chapter-11/recipe-03/README.md)
- [4. Distributing a simple project as Conda package](chapter-11/recipe-04/README.md)
- [5. Distributing a project with dependencies as Conda package](chapter-11/recipe-05/README.md)


### [Chapter 12: Building Documentation](chapter-12/README.md)

- [1. Building documentation using Doxygen](chapter-12/recipe-01/README.md)
- [2. Building documentation using Sphinx](chapter-12/recipe-02/README.md)
- [3. Combining Doxygen and Sphinx](chapter-12/recipe-03/README.md)


### [Chapter 13: Alternative Generators and Cross-compilation](chapter-13/README.md)

- [1. Cross-compiling a hello world example](chapter-13/recipe-01/README.md)
- [2. Cross-compiling a Windows binary with OpenMP parallelization](chapter-13/recipe-02/README.md)


### [Chapter 14: Testing Dashboards](chapter-14/README.md)

- [1. Deploying tests to the CDash dashboard](chapter-14/recipe-01/README.md)
- [2. Reporting test coverage to the CDash dashboard](chapter-14/recipe-02/README.md)
- [3. Using the AddressSanitizer and reporting memory defects to CDash](chapter-14/recipe-03/README.md)
- [4. Using the ThreadSanitizer and reporting data races to CDash](chapter-14/recipe-04/README.md)


### [Chapter 15: Porting a Project to CMake](chapter-15/README.md)
