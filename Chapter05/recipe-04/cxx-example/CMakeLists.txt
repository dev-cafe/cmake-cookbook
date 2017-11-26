cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-04 CXX C Fortran)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

add_subdirectory(deps)

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PUBLIC
    ${BLAS_LIBRARIES}
    ${LAPACK_LIBRARIES}
  PRIVATE
    math
  )
set_source_files_properties(
  ${PROJECT_BINARY_DIR}/deps/FortranC.hpp
  ${PROJECT_BINARY_DIR}/deps/wrap_BLAS_LAPACK/CxxBLAS.hpp
  ${PROJECT_BINARY_DIR}/deps/wrap_BLAS_LAPACK/CxxLAPACK.hpp
  PROPERTIES
    GENERATED TRUE
  )
add_dependencies(linear-algebra BLAS_LAPACK_wrappers)
