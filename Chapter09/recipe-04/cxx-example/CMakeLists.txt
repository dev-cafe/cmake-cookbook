# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-04 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# for testing we will need the python interpreter
find_package(PythonInterp REQUIRED)

# we require boost::python and python development libraries
find_package(PythonLibs REQUIRED)
find_package(Boost REQUIRED COMPONENTS python)

# create python module
add_library(
  account
  MODULE
  account.cpp)

target_link_libraries(
  account
  PUBLIC
  Boost::python
  ${PYTHON_LIBRARIES}
  )

target_include_directories(
  account
  PRIVATE
  ${PYTHON_INCLUDE_DIRS}
  )

# prevent cmake from creating a "lib" prefix
set_target_properties(
  account
  PROPERTIES
    PREFIX ""
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
    PYTHONPATH=${PROJECT_BINARY_DIR}:$ENV{PYTHONPATH}
  )
