cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-04 C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

include(GNUInstallDirs)
include(ExternalProject)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "/usr/local/${PROJECT_NAME}" CACHE PATH "Install path" FORCE)
endif()
message(STATUS "${PROJECT_NAME} install: ${CMAKE_INSTALL_PREFIX}")
set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage${CMAKE_INSTALL_PREFIX})
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")

find_package(FFTW3 CONFIG)
if(FFTW3_FOUND)
  get_property(_loc TARGET FFTW3::fftw3 PROPERTY LOCATION)
  message(STATUS "Found FFTW3: ${_loc} (found version ${FFTW3_VERSION})")
  add_library(fftw3 INTERFACE)  # dummy
else()
  message(STATUS "Suitable FFTW3 could not be located. Downloading and building!")
  ExternalProject_Add(fftw3
    PREFIX
      external
    URL
      http://www.fftw.org/fftw-3.3.7.tar.gz
    URL_HASH
      MD5=0d5915d7d39b3253c1cc05030d79ac47
    DOWNLOAD_NO_PROGRESS
      1
    UPDATE_COMMAND
      ""
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
     INSTALL_COMMAND
       ${CMAKE_MAKE_PROGRAM} install
    )
  set(FFTW3_DIR ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/fftw3 CACHE PATH "path to internally built FFTW3Config.cmake" FORCE)
endif()

ExternalProject_Add(fftw_example
  DEPENDS
    fftw3
  SOURCE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/src
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DFFTW3_DIR=${FFTW3_DIR}
  CMAKE_CACHE_ARGS
    -DCMAKE_PREFIX_PATH:PATH=${CMAKE_PREFIX_PATH}
  BUILD_ALWAYS
    1
  INSTALL_COMMAND
    DESTDIR=${CMAKE_BINARY_DIR}/stage ${CMAKE_MAKE_PROGRAM} install
  )
