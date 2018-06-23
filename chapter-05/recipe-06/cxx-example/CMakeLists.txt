cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

project(recipe-06 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP)

if(OpenMP_FOUND)
  # this will get wiped unless you run cmake with --debug-trycompile
  set(_scratch_dir ${CMAKE_CURRENT_BINARY_DIR}/omp_try_compile)

  try_compile(
    omp_taskloop_test_1
    ${_scratch_dir}
    SOURCES
      ${CMAKE_CURRENT_SOURCE_DIR}/taskloop.cpp
    LINK_LIBRARIES
      OpenMP::OpenMP_CXX
    )
  message(STATUS "Result of try_compile: ${omp_taskloop_test_1}")

  include(CheckCXXSourceCompiles)
  file(READ ${CMAKE_CURRENT_SOURCE_DIR}/taskloop.cpp _snippet)
  set(CMAKE_REQUIRED_LIBRARIES OpenMP::OpenMP_CXX)
  check_cxx_source_compiles("${_snippet}" omp_taskloop_test_2)
  unset(CMAKE_REQUIRED_LIBRARIES)
  message(STATUS "Result of check_cxx_source_compiles: ${omp_taskloop_test_2}")
else()
  message(STATUS "OpenMP not found: no test for taskloop is run")
endif()
