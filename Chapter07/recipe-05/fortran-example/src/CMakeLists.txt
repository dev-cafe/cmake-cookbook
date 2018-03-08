cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(recipe-05_core Fortran)

find_package(HDF5 1.8 REQUIRED COMPONENTS Fortran)
if(HDF5_FOUND)
  set(scratch_directory ${CMAKE_CURRENT_BINARY_DIR}/HDF5_HAS_Fortran2003-test)
  try_compile(HDF5_HAS_Fortran2003
    ${scratch_directory}
    SOURCES
      ${PROJECT_SOURCE_DIR}/test_hdf5_has_fortran2003.f90
    CMAKE_FLAGS
      -DINCLUDE_DIRECTORIES=${HDF5_INCLUDE_DIRS}
    LINK_LIBRARIES
      ${HDF5_Fortran_LIBRARIES}
    )
endif()
if(NOT HDF5_HAS_Fortran2003)
  message(FATAL_ERROR "HDF5 was NOT compiled with Fortran 2003 bindings")
else()
  message(STATUS "Found HDF5 with Fortran2003 bindings (found version ${HDF5_VERSION})")
endif()

add_executable(compound_fortran2003 compound_fortran2003.f90)
target_include_directories(compound_fortran2003
  PUBLIC
    ${HDF5_INCLUDE_DIRS}
  )
target_link_libraries(compound_fortran2003
  PUBLIC
    ${HDF5_Fortran_LIBRARIES}
  )
