# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-04 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# name of the executable
add_executable(dgemm-example "")

# its sources
target_sources(
  dgemm-example
  PRIVATE
  example.cpp
  )

# targets needs to find mkl.h
target_include_directories(
  dgemm-example
  PRIVATE
  ${CMAKE_INSTALL_PREFIX}/include
  )

# locate MKL libraries
set(_mkl_libs)
foreach(_name mkl_intel_lp64 mkl_gnu_thread mkl_core gomp)
  find_library(
    _lib_${_name}
    ${_name}
    HINTS
      ${CMAKE_INSTALL_PREFIX}/lib
    )
    list(APPEND _mkl_libs ${_lib_${_name}})
endforeach()

# link to MKL libraries
target_link_libraries(
  dgemm-example
  PRIVATE
  ${_mkl_libs}
  m
  )

# install the binary
install(
  TARGETS
    dgemm-example
  DESTINATION
    bin
  )
