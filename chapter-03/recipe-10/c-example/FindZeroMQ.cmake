# Find ZeroMQ Headers/Libs
# Adapted from: https://github.com/zeromq/azmq/blob/master/config/FindZeroMQ.cmake

# Variables
# ZMQ_ROOT - set this to a location where ZeroMQ may be found
#
# ZeroMQ_FOUND - True of ZeroMQ found
# ZeroMQ_INCLUDE_DIRS - Location of ZeroMQ includes
# ZeroMQ_LIBRARIES - ZeroMQ libraries

include(FindPackageHandleStandardArgs)

if(NOT ZMQ_ROOT)
  set(ZMQ_ROOT "$ENV{ZMQ_ROOT}")
endif()

if(NOT ZMQ_ROOT)
  find_path(_ZeroMQ_ROOT NAMES include/zmq.h)
else()
  set(_ZeroMQ_ROOT "${ZMQ_ROOT}")
endif()

find_path(ZeroMQ_INCLUDE_DIRS NAMES zmq.h HINTS ${_ZeroMQ_ROOT}/include)

if(ZeroMQ_INCLUDE_DIRS)
  set(_ZeroMQ_H ${ZeroMQ_INCLUDE_DIRS}/zmq.h)

  function(_zmqver_EXTRACT _ZeroMQ_VER_COMPONENT _ZeroMQ_VER_OUTPUT)
    set(CMAKE_MATCH_1 "0")
    set(_ZeroMQ_expr "^[ \\t]*#define[ \\t]+${_ZeroMQ_VER_COMPONENT}[ \\t]+([0-9]+)$")
    file(STRINGS "${_ZeroMQ_H}" _ZeroMQ_ver REGEX "${_ZeroMQ_expr}")
    string(REGEX MATCH "${_ZeroMQ_expr}" ZeroMQ_ver "${_ZeroMQ_ver}")
    set(${_ZeroMQ_VER_OUTPUT} "${CMAKE_MATCH_1}" PARENT_SCOPE)
  endfunction()

  _zmqver_EXTRACT("ZMQ_VERSION_MAJOR" ZeroMQ_VERSION_MAJOR)
  _zmqver_EXTRACT("ZMQ_VERSION_MINOR" ZeroMQ_VERSION_MINOR)
  _zmqver_EXTRACT("ZMQ_VERSION_PATCH" ZeroMQ_VERSION_PATCH)

  message(STATUS "ZeroMQ version: ${ZeroMQ_VERSION_MAJOR}.${ZeroMQ_VERSION_MINOR}.${ZeroMQ_VERSION_PATCH}")

  # We should provide version to find_package_handle_standard_args in the same format as it was requested,
  # otherwise it can't check whether version matches exactly.
  if(ZeroMQ_FIND_VERSION_COUNT GREATER 2)
    set(ZeroMQ_VERSION "${ZeroMQ_VERSION_MAJOR}.${ZeroMQ_VERSION_MINOR}.${ZeroMQ_VERSION_PATCH}")
  else()
    # User has requested ZeroMQ version without patch part => user is not interested in specific patch =>
    # any patch should be an exact match.
    set(ZeroMQ_VERSION "${ZeroMQ_VERSION_MAJOR}.${ZeroMQ_VERSION_MINOR}")
  endif()

  if(NOT ${CMAKE_C_PLATFORM_ID} STREQUAL "Windows")
    find_library(ZeroMQ_LIBRARIES NAMES zmq HINTS ${_ZeroMQ_ROOT}/lib)
  else()
    find_library(
        ZeroMQ_LIBRARY_RELEASE
        NAMES
          libzmq
          "libzmq-${CMAKE_VS_PLATFORM_TOOLSET}-mt-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
        HINTS
          ${_ZeroMQ_ROOT}/lib
        )

    find_library(
        ZeroMQ_LIBRARY_DEBUG
        NAMES
          libzmq_d
          "libzmq-${CMAKE_VS_PLATFORM_TOOLSET}-mt-gd-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
        HINTS
          ${_ZeroMQ_ROOT}/lib)

    # On Windows we have to use corresponding version (i.e. Release or Debug) of ZeroMQ because of `errno` CRT global variable
    # See more at http://www.drdobbs.com/avoiding-the-visual-c-runtime-library/184416623
    set(ZeroMQ_LIBRARIES optimized "${ZeroMQ_LIBRARY_RELEASE}" debug "${ZeroMQ_LIBRARY_DEBUG}")
  endif()
endif()

find_package_handle_standard_args(ZeroMQ FOUND_VAR ZeroMQ_FOUND
  REQUIRED_VARS ZeroMQ_INCLUDE_DIRS ZeroMQ_LIBRARIES
  VERSION_VAR ZeroMQ_VERSION)

if(ZeroMQ_FOUND)
  mark_as_advanced(ZeroMQ_INCLUDE_DIRS ZeroMQ_LIBRARIES ZeroMQ_VERSION
      ZeroMQ_VERSION_MAJOR ZeroMQ_VERSION_MINOR ZeroMQ_VERSION_PATCH)
endif()
