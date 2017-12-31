# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-08 CXX)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message("C++ compiler flags, debug mode: ${CMAKE_CXX_FLAGS_DEBUG}")
message("C++ compiler flags, release mode: ${CMAKE_CXX_FLAGS_RELEASE}")
message("C++ compiler flags, release with debug info mode: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message("C++ compiler flags, minimal release mode: ${CMAKE_CXX_FLAGS_MINSIZEREL}")

file(GLOB _sources geometry_*)

add_library(geometry STATIC ${_sources})

add_executable(compute-areas compute-areas.cpp)
target_link_libraries(compute-areas geometry)
