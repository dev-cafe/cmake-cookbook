# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0003 CXX)

# generate an object library from sources
set(_sources Message.hpp Message.cpp)
add_library(message-objs OBJECT ${_sources})
# This is only needed for older compilers, but doesn't hurt either to have it
set_target_properties(message-objs PROPERTIES POSITION_INDEPENDENT_CODE 1)

add_library(message STATIC $<TARGET_OBJECTS:message-objs>)

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world message)
