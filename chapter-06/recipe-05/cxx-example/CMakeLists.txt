# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-05 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# read PROGRAM_VERSION from file
if(EXISTS "${PROJECT_SOURCE_DIR}/VERSION")
  file(READ "${PROJECT_SOURCE_DIR}/VERSION" PROGRAM_VERSION)
  string(STRIP "${PROGRAM_VERSION}" PROGRAM_VERSION)
else()
  message(FATAL_ERROR "File ${PROJECT_SOURCE_DIR}/VERSION not found")
endif()

# generate file version.h based on version.h.in
configure_file(
  version.h.in
  generated/version.h
  @ONLY
  )

# example code
add_executable(example example.cpp)

# needs to find the generated header file
target_include_directories(
  example
  PRIVATE
    ${PROJECT_BINARY_DIR}/generated
  )
