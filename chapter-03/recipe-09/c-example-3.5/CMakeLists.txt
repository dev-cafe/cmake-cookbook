cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-09 LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED QUIET)

pkg_search_module(
  ZeroMQ
  REQUIRED
    libzeromq libzmq lib0mq
  )

if(ZeroMQ_FOUND)
  message(STATUS "Found ZeroMQ")
endif()

add_executable(hwserver hwserver.c)

target_include_directories(hwserver
  PRIVATE
    ${ZeroMQ_INCLUDE_DIRS}
  )
target_link_libraries(hwserver
  PRIVATE
    ${ZeroMQ_LIBRARIES}
  )

add_executable(hwclient hwclient.c)

target_include_directories(hwclient
  PRIVATE
    ${ZeroMQ_INCLUDE_DIRS}
  )
target_link_libraries(hwclient
  PRIVATE
    ${ZeroMQ_LIBRARIES}
  )
