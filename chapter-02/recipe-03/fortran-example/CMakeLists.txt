# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-03 LANGUAGES Fortran)

# define executable and its source file
add_executable(hello-world hello-world.F90)

# compactly let the preprocessor know about the compiler vendor
target_compile_definitions(hello-world
  PUBLIC "IS_${CMAKE_Fortran_COMPILER_ID}_FORTRAN_COMPILER"
)
