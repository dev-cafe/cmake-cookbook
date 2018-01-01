# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-09 CXX)

message("C++ compiler flags: ${CMAKE_CXX_FLAGS}")

# list sources by globbing
file(GLOB _sources geometry_*)

# These compiler flags will not work on Windows
add_library(geometry STATIC ${_sources})
target_compile_options(geometry
  PRIVATE
    "-fPIC;-Wall;-Wextra;-Wpedantic"
  )

add_executable(compute-areas compute-areas.cpp)
target_compile_options(compute-areas
  PRIVATE
    "-fPIC"
  )

target_link_libraries(compute-areas geometry)
