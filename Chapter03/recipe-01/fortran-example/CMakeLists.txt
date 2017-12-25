# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-01 Fortran)

find_package(PythonInterp)

add_executable(hello-world hello-world.f90)
