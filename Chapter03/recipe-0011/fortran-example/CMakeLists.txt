# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0011 Fortran)

find_package(PythonInterp 2.7 REQUIRED)

add_executable(hello-world hello-world.f90)
