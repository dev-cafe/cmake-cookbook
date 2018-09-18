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

# AppVeyor Visual Studio generators
appveyor-vs:
  ...

# AppVeyor MSYS Makefiles and Ninja generators
appveyor-msys:
  ...

# Circle CI on Linux with Intel 2018
circle-intel:
  ...

# Circle CI on Linux with PGI 18.4
circle-pgi:
  ...
```


## Expected failures

Sometimes we expect a failure. For instance let us imagine we expect
a test to fail on AppVeyor when using the Ninja generator. We can express this using:

```
appveyor-msys:
  definitions:
    - CMAKE_Fortran_COMPILER: 'gfortran'
  failing_generators:
    - 'Ninja'
```


## How to skip a recipe completely

```
appveyor-msys:
  skip_generators:
    - 'MSYS Makefiles'
```

## When to use `failing_generators` and `skip_generators`

Marking generators as expected failures or skipping them achieves more or less
the same goal: not failing CI for recipes that are known not to work under
certain conditions. Using `failing_generators` means that the recipe is actually
tested, but the possible failure is not elevated to an error; whereas using
`skip_generators` will skip the testing altogether.
The semantic to differentiate the use of the two is thus:
1. Use `failing_generators` if the recipe does not work under the current CI set
   up, but _it could be made_ to work. As an example, the Ninja is always marked as
   an expected failure for Fortran recipes, since its set up is rather contrived,
   requiring specific versions specific versions of CMake _and_ Ninja.
   The hurdle could however be overcome in the future.
2. Use `skip_generators` when _you cannot foresee any way_ to make the recipe work.
   This is the case for the Fortran recipes with the Visual Studio generators.


## Bulding targets

```
targets:
  - test
  - docs
```


## Running tests on your computer

```shell
$ pipenv install --three
$ pipenv run python testing/collect_tests.py 'chapter-*/recipe-*'
```

To get more verbose output, use:

```shell
$ env VERBOSE_OUTPUT=ON pipenv run python testing/collect_tests.py 'chapter-*/recipe-*'
```
