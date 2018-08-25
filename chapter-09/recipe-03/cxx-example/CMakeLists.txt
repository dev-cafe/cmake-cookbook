# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-03 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# we default to Release build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# for testing we will need the python interpreter
find_package(PythonInterp REQUIRED)

# directory containing UseCython.cmake and FindCython.cmake
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake-cython)

# this defines cython_add_module
include(UseCython)

# tells UseCython to compile this file as a c++ file
set_source_files_properties(account.pyx PROPERTIES CYTHON_IS_CXX TRUE)

# create python module
cython_add_module(account account.pyx account.cpp)

# location of account.hpp
target_include_directories(account
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
  )

# turn on testing
enable_testing()

# define test
add_test(
  NAME
    python_test
  COMMAND
    ${CMAKE_COMMAND} -E env ACCOUNT_MODULE_PATH=$<TARGET_FILE_DIR:account>
    ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/test.py
  )
