# Find ZeroMQ Headers/Libs
# Adapted from: https://github.com/zeromq/azmq/blob/master/config/FindZeroMQ.cmake

# Variables
# ZeroMQ_ROOT - set this to a location where ZeroMQ may be found
#
# ZeroMQ_FOUND - True of ZeroMQ found
# ZeroMQ_INCLUDE_DIRS - Location of ZeroMQ includes
# ZeroMQ_LIBRARIES - ZeroMQ libraries

if(NOT ZeroMQ_ROOT)
  set(ZeroMQ_ROOT "$ENV{ZeroMQ_ROOT}")
endif()

if(NOT ZeroMQ_ROOT)
  find_path(_ZeroMQ_ROOT NAMES include/zmq.h)
else()
  set(_ZeroMQ_ROOT "${ZeroMQ_ROOT}")
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
    find_library(ZeroMQ_LIBRARIES 
        NAMES 
          zmq 
        HINTS 
          ${_ZeroMQ_ROOT}/lib
          ${_ZeroMQ_ROOT}/lib/x86_64-linux-gnu
        )
  else()
    find_library(ZeroMQ_LIBRARIES
        NAMES
          libzmq
          "libzmq-mt-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
          "libzmq-${CMAKE_VS_PLATFORM_TOOLSET}-mt-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
          libzmq_d
          "libzmq-mt-gd-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
          "libzmq-${CMAKE_VS_PLATFORM_TOOLSET}-mt-gd-${ZeroMQ_VERSION_MAJOR}_${ZeroMQ_VERSION_MINOR}_${ZeroMQ_VERSION_PATCH}"
        HINTS
          ${_ZeroMQ_ROOT}/lib
        )
  endif()
endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(ZeroMQ
  FOUND_VAR
    ZeroMQ_FOUND
  REQUIRED_VARS
    ZeroMQ_INCLUDE_DIRS
    ZeroMQ_LIBRARIES
  VERSION_VAR
    ZeroMQ_VERSION
  )
