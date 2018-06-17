cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-10 LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})

find_package(ZeroMQ REQUIRED)

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
