# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-01 Fortran)

find_package(PythonInterp)

add_executable(hello-world hello-world.f90)
target_compile_options(hello-world
  PUBLIC
    -std=f95
  )
