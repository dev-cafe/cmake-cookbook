cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-03 CXX C Fortran)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

include(FortranCInterface)
FortranCInterface_VERIFY(CXX)
FortranCInterface_HEADER(FortranC.hpp)

set(wrap_BLAS_LAPACK_sources
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.hpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.hpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.cpp
  )

add_custom_command(
  OUTPUT
    ${wrap_BLAS_LAPACK_sources}
  COMMAND
    ${CMAKE_COMMAND} -E tar xzf ${CMAKE_CURRENT_SOURCE_DIR}/wrap_BLAS_LAPACK.tar.gz
  COMMAND
    ${CMAKE_COMMAND} -E touch ${wrap_BLAS_LAPACK_sources}
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/wrap_BLAS_LAPACK.tar.gz
  COMMENT
    "Unpacking C++ wrappers for BLAS/LAPACK"
  VERBATIM
  )

add_library(math "")
target_sources(math
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.cpp
  PUBLIC
    ${PROJECT_BINARY_DIR}/FortranC.hpp
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.hpp
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.hpp
  )
target_include_directories(math
  PUBLIC
    ${PROJECT_BINARY_DIR}
  INTERFACE
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK
  )

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PUBLIC
    ${BLAS_LIBRARIES}
    ${LAPACK_LIBRARIES}
  PRIVATE
    math
  )
