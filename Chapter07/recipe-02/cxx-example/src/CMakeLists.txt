cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-02_core CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Boost 1.61 REQUIRED COMPONENTS filesystem)

add_executable(path-info path-info.cpp)
target_include_directories(path-info
  SYSTEM
  PUBLIC
    Boost::filesystem
  )
target_link_libraries(path-info
  PUBLIC
    Boost::filesystem
  )
