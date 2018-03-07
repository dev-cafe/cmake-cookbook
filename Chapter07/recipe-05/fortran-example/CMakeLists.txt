cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-05 Fortran)

add_subdirectory(external/upstream)

include(ExternalProject)
ExternalProject_Add(${PROJECT_NAME}_core
  DEPENDS
    hdf5_external
  SOURCE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/src
  CMAKE_ARGS
    -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
    -DHDF5_ROOT=${HDF5_ROOT}
  CMAKE_CACHE_ARGS
    -DCMAKE_Fortran_FLAGS:PATH=${CMAKE_Fortran_FLAGS}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    ""
  )
