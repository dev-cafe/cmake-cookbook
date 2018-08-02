cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(use-message
  LANGUAGES CXX
  )

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(message 1 REQUIRED CONFIG)
if(message_FOUND)
  get_property(_loc TARGET message::message-shared PROPERTY LOCATION)
  message(STATUS "Found message: ${_loc} (found version ${message_VERSION})")
  foreach(prop IN ITEMS
      IMPORTED_LOCATION_DEBUG IMPORTED_LOCATION_RELEASE
      IMPORTED_IMPLIB_DEBUG IMPORTED_IMPLIB_RELEASE)
    get_target_property(_item_loc message::message-shared ${prop})
    if(_item_loc)
      get_filename_component(_item_loc ${_item_loc} DIRECTORY)
      list(APPEND _locations ${_item_loc})
    endif()
  endforeach()
endif()

include(CMakePrintHelpers)
cmake_print_properties(
  TARGETS
    message::message-shared
  PROPERTIES
    LOCATION
    IMPORTED_LOCATION_DEBUG
    IMPORTED_LOCATION_RELEASE
    IMPORTED_IMPLIB_DEBUG
    IMPORTED_IMPLIB_RELEASE
    INTERFACE_COMPILE_DEFINITIONS
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_LINK_LIBRARIES
  )

cmake_print_properties(
  TARGETS
    message::message-static
  PROPERTIES
    LOCATION
    IMPORTED_LOCATION_DEBUG
    IMPORTED_LOCATION_RELEASE
    IMPORTED_IMPLIB_DEBUG
    IMPORTED_IMPLIB_RELEASE
    INTERFACE_COMPILE_DEFINITIONS
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_LINK_LIBRARIES
  )

cmake_print_properties(
  TARGETS
    message::hello-world_wDSO
  PROPERTIES
    LOCATION
    INTERFACE_COMPILE_DEFINITIONS
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_LINK_LIBRARIES
  )

cmake_print_properties(
  TARGETS
    message::hello-world_wAR
  PROPERTIES
    LOCATION
    INTERFACE_COMPILE_DEFINITIONS
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_LINK_LIBRARIES
  )

add_executable(use_message use_message.cpp)

target_link_libraries(use_message message::message-shared)

enable_testing()

add_test(
  NAME check_use_message
  COMMAND $<TARGET_FILE:use_message>
  )

if(WIN32)
  list(APPEND _locations $ENV{PATH})
  string(REPLACE ";" "\;" _locations "${_locations}")
  set_tests_properties(check_use_message
    PROPERTIES
      ENVIRONMENT "PATH=${_locations}"
    )
endif()
