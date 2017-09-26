# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0014 CXX C Fortran)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

include(FortranCInterface)
FortranCInterface_VERIFY(CXX)
FortranCInterface_HEADER(FortranC.hpp)

add_library(math CxxLAPACK.cpp)
target_include_directories(math
  PUBLIC
    ${PROJECT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}
  )

add_executable(linear-algebra linear-algebra.cpp)
target_include_directories(linear-algebra
  PRIVATE
    ${PROJECT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}
  )
target_link_libraries(linear-algebra
  PUBLIC
    ${BLAS_LIBRARIES}
    ${LAPACK_LIBRARIES}
  PRIVATE
    math
  )
