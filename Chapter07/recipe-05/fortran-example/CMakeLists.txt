cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

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
  CMAKE_CACHE_ARGS
    -DCMAKE_Fortran_FLAGS:STRING=${CMAKE_Fortran_FLAGS}
    -DHDF5_ROOT:PATH=${HDF5_ROOT}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    ""
  )
