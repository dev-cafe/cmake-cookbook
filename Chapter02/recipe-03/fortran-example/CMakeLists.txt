# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-03 Fortran)

# define executable and its source file
add_executable(hello-world hello-world.F90)

# compactly let the preprocessor know about the compiler vendor
target_compile_definitions(hello-world PUBLIC "-DIS_${CMAKE_Fortran_COMPILER_ID}_FORTRAN_COMPILER")
