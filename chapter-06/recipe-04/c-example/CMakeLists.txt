# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-04 VERSION 2.0.1 LANGUAGES C)

# generate file version.h based on version.h.in
configure_file(
  version.h.in
  generated/version.h
  @ONLY
  )

# example code
add_executable(example example.c)

# needs to find the generated header file
target_include_directories(example
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/generated
  )
