# set minimum cmake version
cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

# project name and language
project(recipe-06 LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(MPI REQUIRED)

add_executable(hello-mpi hello-mpi.c)

target_link_libraries(hello-mpi
  PUBLIC
    MPI::MPI_C
  )
