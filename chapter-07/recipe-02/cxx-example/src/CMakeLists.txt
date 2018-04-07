cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-02_core LANGUAGES CXX)

find_package(Boost 1.61 REQUIRED COMPONENTS filesystem)

add_executable(path-info path-info.cpp)

target_link_libraries(path-info
  PUBLIC
    Boost::filesystem
  )
