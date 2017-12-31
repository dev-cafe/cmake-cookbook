# define minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and supported language
project(recipe-05-sources CXX)

# the pybind11 subdirectory will provide pybind11_add_module
add_subdirectory(
  ${PYBIND11_DIR}
  ${PROJECT_BINARY_DIR}/pybind11
)

# create python module
add_library(
  account
  MODULE
  account.cpp)
target_link_libraries(
  account
  PRIVATE
  pybind11::module
  )
target_include_directories(
  account
  PRIVATE
  ${PYBIND11_DIR}/include
  )
set_target_properties(
  account
  PROPERTIES
    PREFIX "${PYTHON_MODULE_PREFIX}"
    SUFFIX "${PYTHON_MODULE_EXTENSION}"
  )

# install step is important for pip to work
install(
  TARGETS
    account
  LIBRARY DESTINATION .
  )
