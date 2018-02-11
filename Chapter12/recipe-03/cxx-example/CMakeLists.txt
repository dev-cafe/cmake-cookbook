# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-03 CXX)

# name of the executable
add_executable(hello-conda "")

# its sources
target_sources(
  hello-conda
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
