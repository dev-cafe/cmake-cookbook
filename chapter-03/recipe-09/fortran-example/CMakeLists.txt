# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-09 LANGUAGES Fortran C)

find_package(HDF5 1.8 COMPONENTS C Fortran)

# Compile C example
add_executable(h5_cmprss h5_cmprss.c)
target_include_directories(h5_cmprss
  PUBLIC
    ${HDF5_INCLUDE_DIRS}
  )
target_link_libraries(h5_cmprss
  PUBLIC
    ${HDF5_C_LIBRARIES}
  )

# Compile Fortran example, if Fortran bindings were found
if(HDF5_Fortran_LIBRARIES)
  # Was the Fortran 2003 interface to HDF5 enabled?
  # Compile an example from the HDF5 website:
  # https://support.hdfgroup.org/HDF5/examples/f-src.html
  set(scratch_directory ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/hdf5-f03)
  try_compile(HDF5_Fortran2003
    ${scratch_directory}
    SOURCES
      ${PROJECT_SOURCE_DIR}/compound_complex_fortran2003.f90
    CMAKE_FLAGS
      -DINCLUDE_DIRECTORIES=${HDF5_INCLUDE_DIRS}
    LINK_LIBRARIES
      ${HDF5_Fortran_LIBRARIES}
    )

  if(NOT HDF5_Fortran2003)
    message(STATUS "HDF5 was NOT compiled with Fortran 2003 bindings")
  endif()

  add_executable(refregexample refregexample.f90)
  target_include_directories(refregexample
    PUBLIC
      ${HDF5_INCLUDE_DIRS}
    )
  target_link_libraries(refregexample
    PUBLIC
      ${HDF5_Fortran_LIBRARIES}
    )

  if(HDF5_Fortran2003)
    message(STATUS "Fortran 2003 bindings for HDF5 FOUND. Compiling compound_fortran2003.f90")
    add_executable(compound_fortran2003 compound_fortran2003.f90)
    target_include_directories(compound_fortran2003
      PUBLIC
        ${HDF5_INCLUDE_DIRS}
      )
    target_link_libraries(compound_fortran2003
      PUBLIC
        ${HDF5_Fortran_LIBRARIES}
      )
  endif()
endif()
