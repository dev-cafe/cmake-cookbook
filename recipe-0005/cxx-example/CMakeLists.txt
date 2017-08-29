# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0005 CXX)

# list sources by globbing
file(GLOB _sources geometry_*)
message("List of sources")
foreach(_source IN LISTS _sources)
  get_filename_component(_tmp ${_source} NAME)
  message(${_tmp})
endforeach()

add_library(geometry SHARED ${_sources})

add_executable(compute-areas compute-areas.cpp)

target_link_libraries(compute-areas geometry)
