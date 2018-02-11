# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(account-project CXX)

# the pybind11 subdirectory will provide pybind11::module
add_subdirectory(
  ${PYBIND11_DIR}
  ${PROJECT_BINARY_DIR}/pybind11
)

# create python module
add_library(
  account
  MODULE
  account.cpp
  )

target_link_libraries(
  account
  PUBLIC
  pybind11::module
  )

set_target_properties(
  account
  PROPERTIES
    PREFIX "${PYTHON_MODULE_PREFIX}"
    SUFFIX "${PYTHON_MODULE_EXTENSION}"
  )

file(
  COPY
    __init__.py
    version.py
  DESTINATION
    ${PROJECT_BINARY_DIR}
  )

install(
  TARGETS
    account
  LIBRARY DESTINATION .
  )
