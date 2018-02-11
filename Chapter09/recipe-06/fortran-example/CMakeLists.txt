# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported languages
project(recipe-06 CXX Fortran)

# interface and sources
add_subdirectory(account)

# turn on testing
enable_testing()

# require python
find_package(PythonInterp REQUIRED)

# define test
add_test(python_test ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/account/test.py)

# export environment variables needed by the test
set_property(
  TEST
    python_test
  PROPERTY ENVIRONMENT
    PYTHONPATH=${PROJECT_SOURCE_DIR}
    ACCOUNT_LIBRARY_DIR=${PROJECT_BINARY_DIR}/lib
    ACCOUNT_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/account
  )
