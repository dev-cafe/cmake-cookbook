# Testing


## Configuring tests

You can place a file `menu.yml` in the recipe directory, next to `CMakeLists.txt`.
The test script will parse it to set environment variables and CMake definitions for a particular recipe.

You can place global settings under `testing/menu.yml` with the same structure.

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


## Expected failures

Sometimes we expect a failure. For instance let us imagine we expect
a test to fail on AppVeyor when using the Ninja generator. We can express this using:

```
appveyor:
  definitions:
    - CMAKE_Fortran_COMPILER: 'gfortran'
  failing_generators:
    - 'Ninja'
```


## Skipping tests if CMake version is too low

```
travis-linux:
  min_cmake_version: '3.10'
```


## Bulding targets

```
targets:
  - test
  - docs
```


## Running tests on your computer

```shell
pipenv install
python testing/collect_tests.py 'Chapter*/recipe-*'
```
