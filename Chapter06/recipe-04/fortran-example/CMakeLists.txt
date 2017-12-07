# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-04 Fortran)

# version of our project
set(VERSION_MAJOR 2)
set(VERSION_MINOR 0)
set(VERSION_PATCH 1)

# generate version module based on version.f90.in
configure_file(
  version.f90.in
  generated/version.f90
  @ONLY
  )

# example code
add_executable(
  example
  example.f90
  ${PROJECT_BINARY_DIR}/generated/version.f90
  )
