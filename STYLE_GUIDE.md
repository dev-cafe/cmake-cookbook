# Style Guide

## Conventions

- Folders for recipes are named `chapter-N/recipe-M`, where `N` is the chapter number and `M` is a number, _i.e._
  `01`, `02`, etc. In each chapter we restart the recipe counter.
- Each recipe can have more than one example subfolder. These subfolders are
  named `*example*`. Any code must reside in these subfolders.


## Updating the table of contents and generate README files

The `README.md` files that form the table of contents (main `README.md`, chapter `README.md`s and recipe `README.md`s)
are generated from `title.txt` and `abstract.md` files.

This means that you **should not** modify `README.md` files but rather only edit `title.txt` and `abstract.md` files.

To update the `README.md` files, run `python tools/generate-readmes.py` - this file updates `README.md` in place.


## CMake Coding style

### Indentation

We use 2 spaces instead of 4 spaces to reduce the printed page width. No tabs.
Get the integration for [EditorConfig](https://editorconfig.org/) in your
favorite editor to help you keep this convention.


### Case of commands

We use lowercase for commands, _i.e._:
```cmake
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
```
and not:
```cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.5 FATAL_ERROR)
```


### Line continuation

It is OK to put commands on one line if it improves readability, _e.g._:
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


### Variable names

Start an internal variable (_i.e._ one that is not exposed to the user) with an
underscore:
```cmake
set(PUBLIC_VARIABLE "this one is exposed")

set(_temp "this one is internal")
```
