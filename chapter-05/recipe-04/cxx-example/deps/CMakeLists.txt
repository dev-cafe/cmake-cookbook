find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

set(MATH_SRCS
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxBLAS.hpp
  ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK/CxxLAPACK.hpp
  )

add_custom_target(BLAS_LAPACK_wrappers
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS
    ${MATH_SRCS}
  COMMENT
    "Intermediate BLAS_LAPACK_wrappers target"
  VERBATIM
  )

add_custom_command(
  OUTPUT
    ${MATH_SRCS}
  COMMAND
    ${CMAKE_COMMAND} -E tar xzf ${CMAKE_CURRENT_SOURCE_DIR}/wrap_BLAS_LAPACK.tar.gz
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/wrap_BLAS_LAPACK.tar.gz
  COMMENT
    "Unpacking C++ wrappers for BLAS/LAPACK"
  )

add_library(math "")

target_sources(math
  PRIVATE
    ${MATH_SRCS}
  )

target_include_directories(math
  INTERFACE
    ${CMAKE_CURRENT_BINARY_DIR}/wrap_BLAS_LAPACK
  )

# BLAS_LIBRARIES are included in LAPACK_LIBRARIES
target_link_libraries(math
  PUBLIC
    ${LAPACK_LIBRARIES}
  )
