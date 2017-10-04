# Dealing with compiler-dependent source code

This recipe is similar to the previous two in the sense that we will use CMake
to accommodate conditional source code compilation which is dependent on the
chosen compiler. Again, for the sake of portability this is a situation that we
try to avoid but it is also a situation which we are guaranteed to meet sooner
or later.  Following the recipes of this and the previous chapter we have all
the ingredients to achieve this.  Nevertheless it will be useful to discuss the
problem of dealing with compiler-dependent source code since we will learn new
aspects of CMake.


## Ingredients

- A C++ compiler (and a Fortran compiler for the Fortran example)
- CMake (any version higher than 3.0)


## How to do it

We shall first express this example in C++ and later we will demonstrate a
Fortran example and at the same time attempt to refactor and simplify the CMake
code.

Let us consider the following `hello-world.cpp` source code:

```cpp
#include <cstdlib>
#include <iostream>
#include <string>

std::string say_hello() {
#ifdef IS_INTEL_CXX_COMPILER
  // only compiled when Intel compiler is selected
  // such compiler will not compile the other branches
  return std::string("Hello Intel compiler!");
#elif IS_GNU_CXX_COMPILER
  // only compiled when GNU compiler is selected
  // such compiler will not compile the other branches
  return std::string("Hello GNU compiler!");
#elif IS_PGI_CXX_COMPILER
  // etc.
  return std::string("Hello PGI compiler!");
#elif IS_XL_CXX_COMPILER
  return std::string("Hello XL compiler!");
#else
  return std::string("Hello unknown compiler!");
#endif
}

int main() {
  std::cout << say_hello() << std::endl;
  return EXIT_SUCCESS;
}
```

We will configure this code using the following `CMakeLists.txt` configuration file:

```cmake
# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0013 CXX)

# let the preprocessor know about the compiler vendor
if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
    add_definitions(-DIS_INTEL_CXX_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    add_definitions(-DIS_GNU_CXX_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES PGI)
    add_definitions(-DIS_PGI_CXX_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES XL)
    add_definitions(-DIS_XL_CXX_COMPILER)
endif()
# etc ...

# define executable and its source file
add_executable(hello-world hello-world.cpp)
```

The previous recipes have trained our eyes and now we anticipate the result:

```
$ cmake -H. -Bbuild
$ cd build
$ cmake --build .
$ ./hello-world

Hello GNU compiler!
```

If you use a different compiler vendor then our code will provide a different greeting.

The if-statements in the `CMakeLists.txt` file seem repetitive and as
programmers we do not like to repeat ourselves. Can we express this more
compactly? Indeed we can! For this let us turn to a Fortran example that we
will call `hello-world.F90`:

```fortran
program hello

   implicit none

#ifdef IS_Intel_FORTRAN_COMPILER
   print *, 'Hello Intel compiler!'
#elif IS_GNU_FORTRAN_COMPILER
   print *, 'Hello GNU compiler!'
#elif IS_PGI_FORTRAN_COMPILER
   print *, 'Hello PGI compiler!'
#elif IS_XL_FORTRAN_COMPILER
   print *, 'Hello XL compiler!'
#else
   print *, 'Hello unknown compiler!'
#endif

end program
```

We will configure this code with a very compact `CMakeLists.txt`:

```cmake
# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0013 Fortran)

# compactly let the preprocessor know about the compiler vendor
add_definitions(-DIS_${CMAKE_Fortran_COMPILER_ID}_FORTRAN_COMPILER)

# define executable and its source file
add_executable(hello-world hello-world.F90)
```

The behavior is the same as in the C++ example but we have achieved this with a
more elegant CMake code.


## How it works

The preprocessor definitions are defined at configure time by CMake in `CMakeLists.txt` and
passed on to the preprocessor:

```cmake
# let the preprocessor know about the compiler vendor
if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
    add_definitions(-DIS_INTEL_CXX_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    add_definitions(-DIS_GNU_CXX_COMPILER)
endif()
# etc ...
```

The Fortran example contains a very compact expression where we use
the variable `${CMAKE_Fortran_COMPILER_ID}` to construct the preprocessor definition:

```cmake
add_definitions(-DIS_${CMAKE_Fortran_COMPILER_ID}_FORTRAN_COMPILER)
```

To accommodate this we had to change the case from `IS_INTEL_CXX_COMPILER` to `IS_Intel_FORTRAN_COMPILER`.

We could achieve the same for C or C++ using the corresponding variables
`${CMAKE_C_COMPILER_ID}` and `${CMAKE_CXX_COMPILER_ID}`.


## Tips

Use `.F90` suffix for Fortran code which is supposed to be preprocessed and use
`.f90` suffix for code which is not to be preprocessed.
