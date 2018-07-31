find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

include(FortranCInterface)

FortranCInterface_VERIFY()

FortranCInterface_HEADER(
  fc_mangle.h
  MACRO_NAMESPACE "FC_"
  SYMBOLS DSCAL DGESV
  )

add_library(linalg_wrap CxxBLAS.cpp CxxLAPACK.cpp)

target_include_directories(linalg_wrap
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  )

target_link_libraries(linalg_wrap
  PUBLIC
    ${LAPACK_LIBRARIES}
  )
