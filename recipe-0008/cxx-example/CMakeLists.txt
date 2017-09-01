# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0008 CXX)

message("Build type: ${CMAKE_BUILD_TYPE}")
message("Configuration types: ${CMAKE_CONFIGURATION_TYPES}")
message("C++ compiler flags, debug mode: ${CMAKE_CXX_FLAGS_DEBUG}")
message("C++ compiler flags, relese mode: ${CMAKE_CXX_FLAGS_RELEASE}")
message("C++ compiler flags, release with debug info mode: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message("C++ compiler flags, minimal release mode: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
message("C++ compiler flags: ${CMAKE_CXX_FLAGS}")

# list sources by globbing
file(GLOB _sources geometry_*)

# These compiler flags will not work on Windows
add_library(geometry STATIC ${_sources})
target_compile_options(geometry
  PRIVATE
    "-Wall;-Wextra;-Wpedantic"
  )

add_executable(compute-areas compute-areas.cpp)
target_compile_options(compute-areas
  PRIVATE
    "-Wall;-Wextra;-Wpedantic"
  )

target_link_libraries(compute-areas geometry)
