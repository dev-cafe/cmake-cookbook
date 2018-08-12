cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(recipe-09 LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED QUIET)

pkg_search_module(
  ZeroMQ
  REQUIRED
    libzeromq libzmq lib0mq
  IMPORTED_TARGET
  )

if(TARGET PkgConfig::ZeroMQ)
  message(STATUS "Found ZeroMQ")
endif()

add_executable(hwserver hwserver.c)

target_link_libraries(hwserver PkgConfig::ZeroMQ)

add_executable(hwclient hwclient.c)

target_link_libraries(hwclient PkgConfig::ZeroMQ)
