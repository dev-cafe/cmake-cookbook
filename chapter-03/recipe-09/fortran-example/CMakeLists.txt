# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
# C language needed inside FindHDF5
project(recipe-09 LANGUAGES Fortran C)

find_package(HDF5 1.8)
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
  message(STATUS "HDF5 was NOT compiled with Fortran 2003 bindings (--enable-fortran2003)")
endif()
if(NOT HDF5_IS_PARALLEL)
  message(STATUS "HDF5 was NOT compiled with parallel I/O (--enable-parallel)")
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

if(HDF5_IS_PARALLEL)
  message(STATUS "Parallel HDF5 FOUND. Compiling ph5parallel.f90")
  find_package(MPI REQUIRED)
  # Use MPI compiler wrapper for Fortran
  set(CMAKE_Fortran_COMPILER ${MPI_Fortran_COMPILER})

  add_executable(ph5example ph5example.f90)
  target_include_directories(ph5example
    PUBLIC
      ${HDF5_INCLUDE_DIRS}
    )
  target_link_libraries(ph5example
    PUBLIC
      ${HDF5_Fortran_LIBRARIES}
    )
endif()
