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
ExternalProject_Add(
  pybind11_sources
  PREFIX
    "${PROJECT_BINARY_DIR}/pybind11"
  GIT_REPOSITORY
    https://github.com/pybind/pybind11.git
  GIT_TAG
    v2.2
  CONFIGURE_COMMAND
    ""
  BUILD_COMMAND
    ""
  INSTALL_COMMAND
    ""
  CMAKE_ARGS
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}
  )

# process our source code as if it was an external project
ExternalProject_Add(
  account_project
  INSTALL_DIR
    ${PROJECT_BINARY_DIR}/install
  SOURCE_DIR
    ${PROJECT_SOURCE_DIR}/account
  BINARY_DIR
    ${PROJECT_BINARY_DIR}/account
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}/install
    -DPYBIND11_DIR=${PROJECT_BINARY_DIR}/pybind11/src/pybind11_sources/
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}
)

# we need to first fetch pybind11_sources
# before we can use them in account_project
ExternalProject_Add_StepDependencies(account_project configure pybind11_sources)

# turn on testing
enable_testing()

# define test
add_test(
  NAME
    python_test
  COMMAND
    ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/account/test.py
  WORKING_DIRECTORY
    ${PROJECT_BINARY_DIR}
  )

# test needs to know the location of the compiled module
set_property(
  TEST
    python_test
  PROPERTY ENVIRONMENT
    PYTHONPATH=${PROJECT_BINARY_DIR}:$ENV{PYTHONPATH}
  )
