# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-04 VERSION 2.0.1 LANGUAGES Fortran)

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
