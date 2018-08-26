# set minimum cmake version
cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

# project name and language
project(recipe-05 LANGUAGES Fortran)

find_package(OpenMP REQUIRED)

add_executable(example example.f90)

target_link_libraries(example
  PUBLIC
    OpenMP::OpenMP_Fortran
  )
