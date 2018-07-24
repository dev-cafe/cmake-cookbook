cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-01
  VERSION 1.0
  LANGUAGES CXX
  )

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "/usr/local/message" CACHE PATH "Install path" FORCE)
endif()
message(STATUS "Project will be installed to ${CMAKE_INSTALL_PREFIX}")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_subdirectory(src)

# <<< Testing the shared and static libraries >>>

enable_testing()

add_test(
  NAME shared
  COMMAND $<TARGET_FILE:hello-world>
  )

add_test(
  NAME static
  COMMAND $<TARGET_FILE:hello-world-static>
  )
