# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0012 CXX)

# let the preprocessor know about the system name
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    add_definitions(-DIS_LINUX)
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
    add_definitions(-DIS_MAC)
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    add_definitions(-DIS_WINDOWS)
endif()

# define executable and its source file
add_executable(hello-world hello-world.cpp)
