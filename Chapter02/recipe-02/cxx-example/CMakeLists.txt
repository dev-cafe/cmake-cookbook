# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-02 CXX)

# define executable and its source file
add_executable(hello-world hello-world.cpp)

# let the preprocessor know about the system name
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    target_compile_definitions(hello-world PUBLIC "-DIS_LINUX")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    target_compile_definitions(hello-world PUBLIC "-DIS_MAC")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_compile_definitions(hello-world PUBLIC "-DIS_WINDOWS")
endif()
