# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0008 CXX)

# list sources by globbing
file(GLOB _sources geometry_*)

# try the IN LISTS foreach syntax
message(STATUS "List sources using IN LISTS syntax")
foreach(_source IN LISTS _sources)
  get_filename_component(_tmp ${_source} NAME)
  message(${_tmp})
endforeach()
# try the plain foreach syntax
# requires to expand the contents of the variable
message(STATUS "List sources using plain syntax")
foreach(_source ${_sources})
  get_filename_component(_tmp ${_source} NAME)
  message(${_tmp})
endforeach()

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
