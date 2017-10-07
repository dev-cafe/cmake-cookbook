# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-10 Fortran)

# list sources by globbing
file(GLOB _sources geometry_*)

# These compiler flags will not work on Windows
add_library(geometry SHARED ${_sources})
set_target_properties(geometry
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
  )
target_compile_options(geometry
  PUBLIC
    "-std=f2008"
  )

add_executable(compute-areas compute-areas.f90)
target_compile_options(geometry
  PRIVATE
    "-std=f2008"
  )

target_link_libraries(compute-areas geometry)
