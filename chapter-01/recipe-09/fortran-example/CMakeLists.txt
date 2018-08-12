# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-09 LANGUAGES Fortran)

add_library(
  geometry
  SHARED
  geometry_circle.f90
  geometry_polygon.f90
  geometry_rhombus.f90
  geometry_square.f90
  )

add_executable(compute-areas compute-areas.f90)

# These compiler flags will not work on Windows
# Intel or PGI
target_compile_options(geometry
  PRIVATE
    "-std=f2008"
  )
target_link_libraries(compute-areas
  PUBLIC
    geometry
  )
