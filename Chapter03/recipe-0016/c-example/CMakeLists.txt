# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0016 C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(MPI REQUIRED)

add_executable(hello-mpi hello-mpi.c)
target_compile_options(hello-mpi
  PUBLIC
    ${MPI_C_COMPILE_FLAGS}
  )
target_include_directories(hello-mpi
  PUBLIC
    ${MPI_C_INCLUDE_PATH}
  )
target_link_libraries(hello-mpi
  PUBLIC
    ${MPI_C_LIBRARIES}
  )
