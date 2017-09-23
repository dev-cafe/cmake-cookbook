# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-0010 CXX)

add_executable(strong-types strong-types.cpp)
target_include_directories(strong-types PUBLIC ${CMAKE_CURRENT_SOURCE_DIRECTORY})
set_target_properties(strong-types
  PROPERTIES
    CXX_STANDARD 11
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
  )
