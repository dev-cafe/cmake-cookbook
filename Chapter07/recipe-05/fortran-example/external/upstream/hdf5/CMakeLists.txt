find_package(HDF5 1.8 QUIET COMPONENTS Fortran)
if(HDF5_FOUND)
  set(scratch_directory ${CMAKE_CURRENT_BINARY_DIR}/HDF5_HAS_Fortran2003-test)
  try_compile(HDF5_HAS_Fortran2003
    ${scratch_directory}
    SOURCES
      ${CMAKE_CURRENT_SOURCE_DIR}/test_hdf5_has_fortran2003.f90
    CMAKE_FLAGS
      -DINCLUDE_DIRECTORIES=${HDF5_INCLUDE_DIRS}
    LINK_LIBRARIES
      ${HDF5_Fortran_LIBRARIES}
    )
endif()

if(HDF5_FOUND AND HDF5_HAS_Fortran2003)
  message(STATUS "Found HDF5 with Fortran2003 bindings (found version ${HDF5_VERSION})")
  add_library(hdf5_external INTERFACE)
else()
  message(STATUS "Suitable HDF5 could not be located. Downloading and building!")
  include(ExternalProject)
  ExternalProject_Add(hdf5_external
    GIT_REPOSITORY
      https://bitbucket.hdfgroup.org/scm/hdffv/hdf5.git
    GIT_TAG
      hdf5-1_10_1
    UPDATE_COMMAND
      ""
    CONFIGURE_COMMAND
      CC=${CMAKE_C_COMPILER} FC=${CMAKE_Fortran_COMPILER}
        <SOURCE_DIR>/configure --prefix=${DEPS_INSTALL_PREFIX}/hdf5 --enable-fortran
    BUILD_IN_SOURCE
      1
    BUILD_COMMAND
      ${CMAKE_MAKE_PROGRAM}
    INSTALL_COMMAND
      ${CMAKE_MAKE_PROGRAM} install
    )
  set(HDF5_ROOT ${DEPS_INSTALL_PREFIX}/hdf5
    CACHE PATH
      "Path to internally built HDF5"
    FORCE
    )
endif()
