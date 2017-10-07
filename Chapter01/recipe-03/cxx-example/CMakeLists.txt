# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-03 CXX)

# generate a library from sources
set(_sources Message.hpp Message.cpp)
add_library(message STATIC ${_sources})

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world message)
