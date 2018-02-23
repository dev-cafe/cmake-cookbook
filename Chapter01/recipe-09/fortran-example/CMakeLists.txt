# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-10 Fortran)

# list sources by globbing
file(GLOB _sources geometry_*)

# These compiler flags will not work on Windows
add_library(geometry SHARED ${_sources})

add_executable(compute-areas compute-areas.f90)
target_compile_options(geometry PRIVATE "-std=f2008")
target_link_libraries(compute-areas PUBLIC geometry)
