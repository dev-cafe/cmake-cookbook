cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-02_core LANGUAGES CXX)

find_package(Boost 1.61 REQUIRED COMPONENTS filesystem)

add_executable(path-info path-info.cpp)

# if target_link_libraries uses a properly defined import then
# target_include_directories is in principle not needed
# this is kept here because the existence of the SYSTEM flag is used
# in the text of the book
target_include_directories(path-info
  SYSTEM
  PUBLIC
    Boost::filesystem
  )

target_link_libraries(path-info
  PUBLIC
    Boost::filesystem
  )
