cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-08 LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED QUIET)
pkg_search_module(UUID REQUIRED uuid)
if(UUID_FOUND)
  message(STATUS "Found libuuid")
endif()

include(CheckCSourceRuns)

set(_test_uuid
  "
#include <uuid/uuid.h>

int main(int argc, char * argv[]) {
  uuid_t uuid;

  uuid_generate(uuid);

  return 0;
}
  ")

set(CMAKE_REQUIRED_INCLUDES ${UUID_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${UUID_LIBRARIES})
check_c_source_runs("${_test_uuid}" _runs)
unset(CMAKE_REQUIRED_INCLUDES)
unset(CMAKE_REQUIRED_LIBRARIES)

if(NOT _runs)
  message(FATAL_ERROR "Cannot run a simple C executable using libuuid!")
endif()

add_executable(use-uuid use-uuid.cpp)

target_link_libraries(use-uuid
  PUBLIC
    ${UUID_LIBRARIES}
  )
