# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-01 CXX)

# detect operating system
message(STATUS "We are on a ${CMAKE_SYSTEM_NAME} system")

# print custom message depending on the operating system
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "On Linux print this message")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    message(STATUS "On Mac OS X print this message")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    message(STATUS "On Windows print this message")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "AIX")
    message(STATUS "On IBM AIX print this message")
endif()

# define executable and its source file
add_executable(hello-world hello-world.cpp)
