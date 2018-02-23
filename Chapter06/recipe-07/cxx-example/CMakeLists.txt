# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-07 CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# example code
add_executable(example example.cpp)

# needs to find the generated header file
target_include_directories(example PRIVATE ${PROJECT_BINARY_DIR}/generated)

add_custom_command(OUTPUT ${PROJECT_BINARY_DIR}/generated/version.h ALL
                   COMMAND ${CMAKE_COMMAND} -P
                           ${PROJECT_SOURCE_DIR}/git-hash.cmake)

# rebuild version.h every time
add_custom_target(get_git_hash ALL
                  DEPENDS ${PROJECT_BINARY_DIR}/generated/version.h)

# version.h has to be generated before we start building example
add_dependencies(example get_git_hash)
