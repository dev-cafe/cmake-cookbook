# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-04 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# name of the executable
add_executable(hello-conda "")

# its sources
target_sources(hello-conda
  PRIVATE
    example.cpp
  )

# install the binary
install(
  TARGETS
    hello-conda
  DESTINATION
    bin
  )
