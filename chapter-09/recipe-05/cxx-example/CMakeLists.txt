# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-05 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# for testing we will need the python interpreter
find_package(PythonInterp REQUIRED)

# we need ExternalProject functionality
include(ExternalProject)

# fetch pybind11 sources
ExternalProject_Add(pybind11_external
  GIT_REPOSITORY
    https://github.com/pybind/pybind11.git
  GIT_TAG
    v2.2
  CMAKE_ARGS
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/stage
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}  # unused, but needs working compiler
    -DCMAKE_CXX_STANDARD=11
    -DPYBIND11_TEST=OFF
  LOG_DOWNLOAD 1
  LOG_UPDATE 1
  LOG_CONFIGURE 1
  LOG_BUILD 1
  LOG_INSTALL 1
  )

# process our source code as if it was an external project
ExternalProject_Add(account-project
  DEPENDS pybind11_external
  SOURCE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/account
  BINARY_DIR
    ${CMAKE_CURRENT_BINARY_DIR}/account
  CMAKE_ARGS
    -Dpybind11_DIR=${CMAKE_CURRENT_BINARY_DIR}/stage/share/cmake/pybind11
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/install
  )

# turn on testing
enable_testing()

# define test
add_test(
  NAME
    python_test
  COMMAND
    ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/account/test.py
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  )

# test needs to know the location of the compiled module
set_tests_properties(python_test
  PROPERTIES
    ENVIRONMENT PYTHONPATH=${CMAKE_CURRENT_BINARY_DIR}:$ENV{PYTHONPATH}
  )
