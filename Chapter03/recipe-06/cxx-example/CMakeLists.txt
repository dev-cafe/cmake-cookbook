# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-06 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(MPI REQUIRED)

# Use MPI compiler wrapper for C++
set(CMAKE_CXX_COMPILER ${MPI_CXX_COMPILER})

add_executable(hello-mpi hello-mpi.cpp)
