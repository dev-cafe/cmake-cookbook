# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0016 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(MPI REQUIRED)

# Use MPI compiler wrapper for C++
set(CMAKE_CXX_COMPILER ${MPI_CXX_COMPILER})

add_executable(hello-mpi hello-mpi.cpp)
target_compile_options(hello-mpi
  PUBLIC
    ${MPI_CXX_COMPILE_FLAGS}
  )
target_include_directories(hello-mpi
  PUBLIC
    ${MPI_CXX_INCLUDE_PATH}
  )
target_link_libraries(hello-mpi
  PUBLIC
    ${MPI_CXX_LIBRARIES}
  )
set_target_properties(hello-mpi
  PROPERTIES
    LINK_FLAGS ${MPI_CXX_LINK_FLAGS}
  )
