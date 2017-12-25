find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

include(FortranCInterface)
FortranCInterface_VERIFY(CXX)
FortranCInterface_HEADER(FortranC.hpp)

add_library(linalg_wrap CxxBLAS.cpp CxxLAPACK.cpp)
target_include_directories(linalg_wrap
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  )
target_link_libraries(linalg_wrap
  PUBLIC
    ${LAPACK_LIBRARIES}
    ${CMAKE_Fortran_IMPLICIT_LINK_LIBRARIES}
  )
