# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(account-project LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# the pybind11 package will provide the pybind11::module imported target
find_package(pybind11 CONFIG REQUIRED)

# create python module
add_library(account
  MODULE
    account.cpp
  )

target_link_libraries(account
  PUBLIC
    pybind11::module
  )

set_target_properties(account
  PROPERTIES
    PREFIX "${PYTHON_MODULE_PREFIX}"
    SUFFIX "${PYTHON_MODULE_EXTENSION}"
  )

file(
  COPY
    __init__.py
    version.py
  DESTINATION
    ${CMAKE_CURRENT_BINARY_DIR}
  )

install(
  TARGETS
    account
  LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}
  )
