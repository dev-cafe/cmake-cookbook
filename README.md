[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/bast/cmake-recipes/master/LICENSE)

[![Travis branch](https://img.shields.io/travis/bast/cmake-recipes/master.svg?style=flat-square)](https://travis-ci.org/bast/cmake-recipes)
[![AppVeyor branch](https://img.shields.io/appveyor/ci/bast/cmake-recipes/master.svg?style=flat-square)](https://ci.appveyor.com/project/bast/cmake-recipes/branch/master)
[![Drone branch](https://www.drone-ci.science/api/badges/bast/cmake-recipes/status.svg?style=flat-square)](https://www.drone-ci.science/bast/cmake-recipes)

[![GitHub issues](https://img.shields.io/github/issues/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/issues)
[![GitHub forks](https://img.shields.io/github/forks/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/network)
[![GitHub stars](https://img.shields.io/github/stars/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/stargazers)


# Experimental collection of CMake recipes


## Recipes

- [Chapter 1: From a Simple Executable to Libraries](Chapter01/README.md)
- [Chapter 2: Detecting the Environment](Chapter02/README.md)
- [Chapter 3: Detecting External Libraries and Programs](Chapter03/README.md)
- [Chapter 4: Creating and Running Tests](Chapter04/README.md)
- [Chapter 5: Configure-time and Build-time Operations](Chapter05/README.md)
- [Chapter 6: Generating Source Code](Chapter06/README.md)
- [Chapter 7: Fetching, Building, and Linking External Sources](Chapter07/README.md)
- [Chapter 8: Structuring Projects](Chapter08/README.md)
- [Chapter 9: Mixed-language Projects](Chapter09/README.md)
- [Chapter 10: Writing an Installer](Chapter10/README.md)
- [Chapter 11: Generating Source Archives and Binary Distributions](Chapter11/README.md)
- [Chapter 12: Creating Python Packages Which Require CMake](Chapter12/README.md)
- [Chapter 13: Building Documentation](Chapter13/README.md)
- [Chapter 14: Alternatives to Makefiles and Cross-compilation](Chapter14/README.md)
- [Chapter 15: Testing Dashboards](Chapter15/README.md)
- [Chapter 16: Porting a Project to CMake](Chapter16/README.md)


## Contributing

### Conventions

- Folders for recipes are named `ChapterN/recipe-M`, where `N` is the chapter number and `M` is a number, _i.e._
  `01`, `02`, etc. In each chapter we restart the recipe counter.
- Each recipe can have more than one example subfolder. These subfolders are
  named `*-example`.
- Any code for the recipes **must be stored** in a `prefix-example`
  subdirectory.


### Configuring tests

You can place a file `menu.yml` in the recipe directory, next to `CMakeLists.txt`.
The test script will parse it to set environment variables and CMake definitions for a particular recipe.

You can place global settings under `.scripts/menu.yml` with the same structure.

Example:
```yaml
# used when run locally
local:
  # environment variables to be set
  env:
    - SOME_ENVIRONMENT_VAR: 'example'
    - ANOTHER_VAR: 'foo'
  # these will be passed to CMake as -DFOO=bar -DSOME_OPTION=ON
  definitions:
    - FOO: bar
    - SOME_OPTION: ON

# Travis CI on Linux
travis-linux:
  definitions:
    - ...

# Travis CI on OS X
travis-osx:
  ...

# AppVeyor
appveyor:
  ...

# Drone CI
drone:
  ...
```


### Expected failures

Sometimes we expect a failure. For instance let us imagine we expect
a test to fail on AppVeyor when using the Ninja generator. We can express this using:

```
appveyor:
  definitions:
    - CMAKE_Fortran_COMPILER: 'gfortran'
  failing_generators:
    - 'Ninja'
```


### Running tests on your computer

```shell
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
python .scripts/ci_configure_build_test.py 'Chapter*/recipe-*'
```


### Coding style

#### Indentation

We use 2 spaces instead of 4 spaces to reduce the printed page width.
No tabs.


#### Case of commands

We use lowercase for commands, i.e.:
```cmake
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
```
and not:
```cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.5 FATAL_ERROR)
```


#### Line continuation

It is OK to put commands on one line if it improves readability, e.g.:
```cmake
list(APPEND CXX_BASIC_FLAGS "-g3" "-O1")
```

For line continuation we use the following style:
```cmake
target_compile_options(asan-example
  PUBLIC
    ${CXX_BASIC_FLAGS}
    ${_asan_flags}
  )

set(_whathaveyou
  item1
  item2
  item3
  )
```


#### Variable names

Start an internal variable (i.e. one that is not exposed to the user) with an
underscore:
```cmake
set(PUBLIC_VARIABLE "this one is exposed")

set(_temp "this one is internal")
```
