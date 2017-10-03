# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0013 Fortran)

# compactly let the preprocessor know about the compiler vendor
add_definitions(-DIS_${CMAKE_Fortran_COMPILER_ID}_COMPILER)

# define executable and its source file
add_executable(hello-world hello-world.F90)
