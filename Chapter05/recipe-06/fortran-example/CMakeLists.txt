cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-06 Fortran)

find_package(HDF5 1.8 REQUIRED COMPONENTS Fortran)
# Was the Fortran 2003 interface to HDF5 enabled? Compile an example from the
# HDF5 website: https://support.hdfgroup.org/HDF5/examples/f-src.html
set(scratch_directory ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/hdf5)
try_compile(HDF5_Fortran2003_test1
            ${scratch_directory}
            SOURCES
            ${PROJECT_SOURCE_DIR}/compound_complex_fortran2003.f90
            CMAKE_FLAGS -DINCLUDE_DIRECTORIES=${HDF5_INCLUDE_DIRS}
            LINK_LIBRARIES ${HDF5_Fortran_LIBRARIES})
message(STATUS "Result of try_compile: ${HDF5_Fortran2003_test1}")

include(CheckFortranSourceCompiles)
file(READ ${PROJECT_SOURCE_DIR}/compound_complex_fortran2003.f90 _snippet)
set(CMAKE_REQUIRED_FLAGS -ffree-form)
set(CMAKE_REQUIRED_INCLUDES ${HDF5_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${HDF5_Fortran_LIBRARIES})
check_fortran_source_compiles("${_snippet}" HDF5_Fortran2003_test2)
unset(CMAKE_REQUIRED_FLAGS)
unset(CMAKE_REQUIRED_INCLUDES)
unset(CMAKE_REQUIRED_LIBRARIES)

if(NOT HDF5_Fortran2003_test1 OR NOT HDF5_Fortran2003_test2)
  message(
    STATUS
      "HDF5 was NOT compiled with Fortran 2003 bindings (--enable-fortran2003)")
endif()

if(HDF5_Fortran2003_test1 AND HDF5_Fortran2003_test2)
  message(
    STATUS
      "Fortran 2003 bindings for HDF5 FOUND. Compiling compound_fortran2003.f90"
    )
  add_executable(compound_fortran2003 compound_fortran2003.f90)
  target_include_directories(compound_fortran2003 PUBLIC ${HDF5_INCLUDE_DIRS})
  target_link_libraries(compound_fortran2003 PUBLIC ${HDF5_Fortran_LIBRARIES})
endif()
