
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/bast/cmake-recipes/master/LICENSE)

[![Travis branch](https://img.shields.io/travis/bast/cmake-recipes/master.svg?style=flat-square)](https://travis-ci.org/bast/cmake-recipes)
[![AppVeyor branch](https://img.shields.io/appveyor/ci/bast/cmake-recipes/master.svg?style=flat-square)](https://ci.appveyor.com/project/bast/cmake-recipes/branch/master)

[![GitHub issues](https://img.shields.io/github/issues/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/issues)
[![GitHub forks](https://img.shields.io/github/forks/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/network)
[![GitHub stars](https://img.shields.io/github/stars/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/stargazers)


# CMake cookbook recipes

- [Testing](testing/README.md)
- [Contributing](contributing/README.md)


## Table of contents



### [Chapter 1: From a Simple Executable to Libraries](chapter-01/README.md)

- [Compiling a single source file into an executable](chapter-01/recipe-01/README.md)
- [Switching Generators](chapter-01/recipe-02/README.md)
- [Building and Linking Static and Shared Libraries](chapter-01/recipe-03/README.md)
- [Controlling Compilation with Conditionals](chapter-01/recipe-04/README.md)
- [Presenting Options to the User](chapter-01/recipe-05/README.md)
- [Specifying the Compiler](chapter-01/recipe-06/README.md)
- [Switching the Build Type](chapter-01/recipe-07/README.md)
- [Controlling Compiler Flags](chapter-01/recipe-08/README.md)
- [Setting the Standard for the Language](chapter-01/recipe-09/README.md)
- [Using Control Flow Constructs](chapter-01/recipe-10/README.md)


### [Chapter 2: Detecting the Environment](chapter-02/README.md)

- [Discovering the operating system](chapter-02/recipe-01/README.md)
- [Dealing with platform-dependent source code](chapter-02/recipe-02/README.md)
- [Dealing with compiler-dependent source code](chapter-02/recipe-03/README.md)
- [Discovering the host processor architecture](chapter-02/recipe-04/README.md)
- [Discovering the host processor instruction set](chapter-02/recipe-05/README.md)
- [Enabling vectorization for the Eigen library](chapter-02/recipe-06/README.md)


### [Chapter 3: Detecting External Libraries and Programs](chapter-03/README.md)

- [Detecting the Python Interpreter](chapter-03/recipe-01/README.md)
- [Detecting the Python Library](chapter-03/recipe-02/README.md)
- [Detecting Python Modules](chapter-03/recipe-03/README.md)
- [Detecting the BLAS and LAPACK Math Libraries](chapter-03/recipe-04/README.md)
- [Detecting the OpenMP Parallel Environment](chapter-03/recipe-05/README.md)
- [Detecting the MPI Parallel Environment](chapter-03/recipe-06/README.md)
- [Detecting the Eigen Library](chapter-03/recipe-07/README.md)
- [Detecting the Boost Libraries](chapter-03/recipe-08/README.md)
- [Detecting External Libraries. I. Using pkg-config](chapter-03/recipe-09/README.md)
- [Detecting External Libraries. II. Writing a find-module](chapter-03/recipe-10/README.md)


### [Chapter 4: Creating and Running Tests](chapter-04/README.md)

- [Creating a simple unit test example](chapter-04/recipe-01/README.md)
- [Define a unit test using the Catch2 library](chapter-04/recipe-02/README.md)
- [Define a unit test and link against Google test](chapter-04/recipe-03/README.md)
- [Define a unit test and link against Boost test](chapter-04/recipe-04/README.md)
- [Dynamic analysis to detect memory defects](chapter-04/recipe-05/README.md)
- [Testing expected failures](chapter-04/recipe-06/README.md)
- [Using timeouts for long tests](chapter-04/recipe-07/README.md)
- [Running tests in parallel](chapter-04/recipe-08/README.md)
- [Running a subset of tests](chapter-04/recipe-09/README.md)
- [Using test fixtures](chapter-04/recipe-10/README.md)


### [Chapter 5: Configure-time and Build-time Operations](chapter-05/README.md)

- [Using platform-independent file operations](chapter-05/recipe-01/README.md)
- [Running a custom command at configure-time](chapter-05/recipe-02/README.md)
- [Running a custom command at build-time I](chapter-05/recipe-03/README.md)
- [Running a custom command at build-time II](chapter-05/recipe-04/README.md)
- [Running custom commands for specific targets at build-time](chapter-05/recipe-05/README.md)
- [Probing compilation](chapter-05/recipe-06/README.md)
- [Probing compiler flags](chapter-05/recipe-07/README.md)
- [Probing execution](chapter-05/recipe-08/README.md)
- [Fine-tuning with generator expressions](chapter-05/recipe-09/README.md)


### [Chapter 6: Generating Source Code](chapter-06/README.md)

- [Generating sources at configure-time](chapter-06/recipe-01/README.md)
- [Generating source code at configure-time using Python](chapter-06/recipe-02/README.md)
- [Generating source code at build-time using Python](chapter-06/recipe-03/README.md)
- [Recording the project version information for reproducibility](chapter-06/recipe-04/README.md)
- [Recording the project version from a file](chapter-06/recipe-05/README.md)
- [Recording the Git hash at configure-time](chapter-06/recipe-06/README.md)
- [Recording the Git hash at build-time](chapter-06/recipe-07/README.md)


### [Chapter 7: The Superbuild Pattern](chapter-07/README.md)

- [Using the superbuild pattern](chapter-07/recipe-01/README.md)
- [Managing dependencies with a superbuild I. The Boost libraries](chapter-07/recipe-02/README.md)
- [Managing dependencies with a superbuild II. The FFTW library](chapter-07/recipe-03/README.md)
- [Managing dependencies with a superbuild III. The Eigen library](chapter-07/recipe-04/README.md)
- [Managing dependencies with a superbuild IV. The HDF5 library](chapter-07/recipe-05/README.md)
- [Managing your project as a superbuild](chapter-07/recipe-06/README.md)


### [Chapter 8: Structuring Projects](chapter-08/README.md)

- [Defining a macro with named arguments](chapter-08/recipe-01/README.md)
- [Splitting CMake sources into modules](chapter-08/recipe-02/README.md)
- [Function to test and set compiler flags](chapter-08/recipe-03/README.md)
- [Defining a function or macro with named arguments](chapter-08/recipe-04/README.md)
- [Redefining functions and macros](chapter-08/recipe-05/README.md)
- [Deprecating functions, macros, and variables](chapter-08/recipe-06/README.md)
- [Limiting scope with add_subdirectory](chapter-08/recipe-07/README.md)
- [Avoiding global variables using target_sources](chapter-08/recipe-08/README.md)
- [Organizing Fortran projects](chapter-08/recipe-09/README.md)


### [Chapter 9: Mixed-language Projects](chapter-09/README.md)

- [Building Fortran projects that use C/C++ libraries](chapter-09/recipe-01/README.md)
- [Building C/C++ projects that use Fortran libraries](chapter-09/recipe-02/README.md)
- [Building C++ and Python projects using Cython](chapter-09/recipe-03/README.md)
- [Building C++ and Python projects using Boost.Python](chapter-09/recipe-04/README.md)
- [Building C++ and Python projects using pybind11](chapter-09/recipe-05/README.md)
- [Mixing C, C++, Fortran, and Python using Python CFFI](chapter-09/recipe-06/README.md)


### [Chapter 10: Writing an Installer](chapter-10/README.md)

- [Installing your project](chapter-10/recipe-01/README.md)
- [Installing following GNU standards](chapter-10/recipe-02/README.md)
- [Generating export headers](chapter-10/recipe-03/README.md)
- [Exporting your targets](chapter-10/recipe-04/README.md)
- [Installing a superbuild](chapter-10/recipe-05/README.md)


### [Chapter 11: Generating Source Archives and Binary Distributions](chapter-11/README.md)

- [Generating source archives](chapter-11/recipe-01/README.md)
- [Generating binary archives](chapter-11/recipe-02/README.md)
- [Generating DEB packages](chapter-11/recipe-03/README.md)
- [Generating RPM packages](chapter-11/recipe-04/README.md)
- [Generating an NSIS installer for Windows](chapter-11/recipe-05/README.md)


### [Chapter 12: Distributing CMake projects via PyPI or Conda](chapter-12/README.md)

- [Distributing a C++/Python project built with CMake/pybind11 via PyPI](chapter-12/recipe-01/README.md)
- [Distributing a C/Fortran/Python project build with CMake/CFFI via PyPI](chapter-12/recipe-02/README.md)
- [Distributing a simple project as Conda package](chapter-12/recipe-03/README.md)
- [Distributing a project with dependencies as Conda package](chapter-12/recipe-04/README.md)


### [Chapter 13: Building Documentation](chapter-13/README.md)

- [Building documentation using Doxygen](chapter-13/recipe-01/README.md)
- [Building documentation using Sphinx](chapter-13/recipe-02/README.md)
- [Combining Doxygen and Sphinx](chapter-13/recipe-03/README.md)


### [Chapter 14: Alternative Generators and Cross-compilation](chapter-14/README.md)

- [Hello world example](chapter-14/recipe-01/README.md)
- [Cross-compiling a Windows binary with OpenMP parallelization](chapter-14/recipe-02/README.md)


### [Chapter 15: Testing Dashboards](chapter-15/README.md)

- [Deploying tests to the CDash dashboard](chapter-15/recipe-01/README.md)
- [Reporting test coverage to the CDash dashboard](chapter-15/recipe-02/README.md)
- [Using the AddressSanitizer and reporting memory defects to CDash](chapter-15/recipe-03/README.md)
- [Using the ThreadSanitizer and reporting data races to CDash](chapter-15/recipe-04/README.md)


### [Chapter 16: Porting a Project to CMake](https://github.com/bast/vim/compare/master...cmake-support)
