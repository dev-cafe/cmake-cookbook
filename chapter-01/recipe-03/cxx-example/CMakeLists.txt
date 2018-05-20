# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-03 LANGUAGES CXX)

# generate a library from sources
add_library(message
  STATIC
    Message.hpp
    Message.cpp
  )

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world message)
