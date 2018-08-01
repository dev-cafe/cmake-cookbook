find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

include(FortranCInterface)

FortranCInterface_VERIFY(CXX)

FortranCInterface_HEADER(
  fc_mangle.h
  MACRO_NAMESPACE "FC_"
  SYMBOLS DSCAL DGESV
  )

add_library(math "")

target_sources(math
  PRIVATE
    CxxBLAS.cpp
    CxxLAPACK.cpp
  )

target_include_directories(math
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  )

target_link_libraries(math
  PUBLIC
    ${LAPACK_LIBRARIES}
  )
