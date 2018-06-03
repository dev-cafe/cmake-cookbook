# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-07 LANGUAGES C CXX)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

message(STATUS "C compiler flags, debug mode: ${CMAKE_C_FLAGS_DEBUG}")
message(STATUS "C compiler flags, release mode: ${CMAKE_C_FLAGS_RELEASE}")
message(STATUS "C compiler flags, release with debug info mode: ${CMAKE_C_FLAGS_RELWITHDEBINFO}")
message(STATUS "C compiler flags, minimal release mode: ${CMAKE_C_FLAGS_MINSIZEREL}")

message(STATUS "C++ compiler flags, debug mode: ${CMAKE_CXX_FLAGS_DEBUG}")
message(STATUS "C++ compiler flags, release mode: ${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "C++ compiler flags, release with debug info mode: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message(STATUS "C++ compiler flags, minimal release mode: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
