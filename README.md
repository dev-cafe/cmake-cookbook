[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/bast/cmake-recipes/master/LICENSE)

[![Travis branch](https://img.shields.io/travis/bast/cmake-recipes/master.svg?style=flat-square)](https://travis-ci.org/bast/cmake-recipes)
[![AppVeyor branch](https://img.shields.io/appveyor/ci/bast/cmake-recipes/master.svg?style=flat-square)](https://ci.appveyor.com/project/bast/cmake-recipes/branch/master)

[![GitHub issues](https://img.shields.io/github/issues/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/issues)
[![GitHub forks](https://img.shields.io/github/forks/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/network)
[![GitHub stars](https://img.shields.io/github/stars/bast/cmake-recipes.svg?style=flat-square)](https://github.com/bast/cmake-recipes/stargazers)


# Experimental collection of CMake recipes


## Conventions

- Folders for recipes are named `ChapterN/recipe-M`, where `N` is the chapter number and `M` is a number, _i.e._
  `0000`, `0001` and so forth.
- Each recipe can have more than one example subfolder. These subfolders are
  named `prefix-example`. `prefix` can be anything of your choice, _e.g._
`cxx-example` is a valid name.
- Any code for the recipes **must be stored** in a `prefix-example`
  subdirectory.


## Configuring tests

You can place an optional `config.yml` file in the recipe directory, next to `CMakeLists.txt`.
If present, the test script will parse it to set environment variables and CMake definitions for a particular recipe.

Example:
```yaml
# environment variables to be set
env:
  SOME_ENVIRONMENT_VAR: 'example'
  ANOTHER_VAR: 'foo'

# these will be passed to CMake as -DFOO=bar -DSOME_OPTION=ON
definitions:
  FOO: bar
  SOME_OPTION: ON
```


## Running tests on your computer

```shell
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
python .scripts/ci_configure_build_test.py 'Chapter*/recipe-*'
```


## Recipes

- [Chapter 1: From a Simple Executable to Libraries](Chapter01/README.md)
- [Chapter 2: Detecting the Environment](Chapter02/README.md)
- [Chapter 3: Detecting External Libraries and Programs](Chapter03/README.md)
- [Chapter 4: Alternatives to Makefiles and Cross-compilation](Chapter04/README.md)
- [Chapter 5: Configure-time and Build-time Operations](Chapter05/README.md)
- [Chapter 6: Generating Source Code](Chapter06/README.md)
- [Chapter 7: Fetching, Building, and Linking External Sources](Chapter07/README.md)
- [Chapter 8: Building Documentation](Chapter08/README.md)
- [Chapter 9: Structuring Projects](Chapter09/README.md)
- [Chapter 10: Porting a Project to CMake](Chapter10/README.md)
- [Chapter 11: Mixed-language Projects](Chapter11/README.md)
- [Chapter 12: Creating and Running Tests](Chapter12/README.md)
- [Chapter 13: Testing Dashboards](Chapter13/README.md)
- [Chapter 14: Writing an Installer](Chapter14/README.md)
- [Chapter 15: Generating Source Archives and Binary Distributions](Chapter15/README.md)
- [Chapter 16: Creating Python Packages Which Require CMake](Chapter16/README.md)
