cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-09 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED QUIET)
pkg_search_module(UUID REQUIRED uuid)
if(UUID_FOUND)
  message(STATUS "Found libuuid")
endif()

add_executable(use-uuid use-uuid.cpp)
target_link_libraries(use-uuid ${UUID_LIBRARIES})
