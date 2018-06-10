# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-05 LANGUAGES Fortran)

find_package(OpenMP REQUIRED)

add_executable(example example.f90)

target_compile_options(example
  PUBLIC
    ${OpenMP_Fortran_FLAGS}
  )

set_target_properties(example
  PROPERTIES
    LINK_FLAGS ${OpenMP_Fortran_FLAGS}
  )
