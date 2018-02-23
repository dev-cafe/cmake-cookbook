# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-05 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP REQUIRED)

add_executable(hello-openmp hello-openmp.cpp)
target_compile_options(hello-openmp PUBLIC ${OpenMP_CXX_FLAGS})
set_target_properties(hello-openmp PROPERTIES LINK_FLAGS ${OpenMP_CXX_FLAGS})
