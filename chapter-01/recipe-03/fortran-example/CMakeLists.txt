# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-03 LANGUAGES Fortran)

add_library(message
  SHARED
    message.f90
  )

add_executable(hello-world hello-world.f90)

target_link_libraries(hello-world message)
