cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# Fortran needed to discover LAPACK with some compilers
project(recipe-04 LANGUAGES CXX Fortran)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(deps)

add_executable(linear-algebra linear-algebra.cpp)

target_link_libraries(linear-algebra
  PRIVATE
    math
  )
