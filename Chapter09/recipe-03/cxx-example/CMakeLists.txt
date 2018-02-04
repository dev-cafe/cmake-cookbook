# define minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and supported language
project(recipe-03 CXX)

# for testing we will need the python interpreter
find_package(PythonInterp REQUIRED)

# directory contains UseCython.cmake and FindCython.cmake
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake-cython)

# this defines cython_add_module
include(UseCython)

# tells UseCython to compile this file as a c++ file
set_source_files_properties(account.pyx PROPERTIES CYTHON_IS_CXX TRUE)

# create python module
cython_add_module(account account.pyx account.cpp)

# location of account.hpp
target_include_directories(
  account
  PRIVATE
  ${PROJECT_SOURCE_DIR}
  )

# turn on testing
enable_testing()

# define test
add_test(
  NAME
    python_test
  COMMAND
    ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test.py
  )

# test needs to know the location of the compiled module
set_property(
  TEST
    python_test
  PROPERTY ENVIRONMENT
    PYTHONPATH=${PROJECT_BINARY_DIR}
  )
