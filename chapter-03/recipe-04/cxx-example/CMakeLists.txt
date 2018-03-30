# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-04 LANGUAGES CXX C Fortran)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

add_library(math CxxBLAS.cpp CxxLAPACK.cpp)
target_include_directories(math
  PUBLIC
    ${PROJECT_SOURCE_DIR}
  )
target_link_libraries(math
  PUBLIC
    ${LAPACK_LIBRARIES}
  )

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PRIVATE
    math
  )
