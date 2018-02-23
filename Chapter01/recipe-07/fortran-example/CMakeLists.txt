# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-08 Fortran)

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message("Fortran compiler flags, debug mode: ${CMAKE_Fortran_FLAGS_DEBUG}")
message("Fortran compiler flags, release mode: ${CMAKE_Fortran_FLAGS_RELEASE}")
message(
  "Fortran compiler flags, release with debug info mode: ${CMAKE_Fortran_FLAGS_RELWITHDEBINFO}"
  )
message(
  "Fortran compiler flags, minimal release mode: ${CMAKE_Fortran_FLAGS_MINSIZEREL}"
  )

add_executable(hello-world hello-world.f90)
