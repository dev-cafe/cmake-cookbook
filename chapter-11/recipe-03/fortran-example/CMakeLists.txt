# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported languages
project(recipe-03 LANGUAGES CXX Fortran)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# specify where to place libraries
include(GNUInstallDirs)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})

# interface and sources
add_subdirectory(account)

# turn on testing
enable_testing()

# require python
find_package(PythonInterp REQUIRED)

# define test
add_test(python_test ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/account/test.py)

# export environment variables needed by the test
set_property(
  TEST python_test
  PROPERTY ENVIRONMENT
    PYTHONPATH=${CMAKE_CURRENT_SOURCE_DIR}:$ENV{PYTHONPATH}
    ACCOUNT_INCLUDE_DIR=${CMAKE_CURRENT_SOURCE_DIR}/account
    ACCOUNT_LIBRARY_DIR=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
  )
