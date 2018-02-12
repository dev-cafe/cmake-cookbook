# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-03 Fortran)


set(_sources message.f90)
add_library(message SHARED ${_sources})

add_executable(hello-world hello-world.f90)

target_link_libraries(hello-world message)
