# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-04 C)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# version of our project
set(VERSION_MAJOR 2)
set(VERSION_MINOR 0)
set(VERSION_PATCH 1)

# generate file version.h based on version.h.in
configure_file(
  ${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_BINARY_DIR}/generated/version.h
  @ONLY
  )

# example code
add_executable(example example.c)

# needs to find the generated header file
target_include_directories(
  example
  PRIVATE
    ${PROJECT_BINARY_DIR}/generated
  )
