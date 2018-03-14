cmake_minimum_required(VERSION 3.6 FATAL_ERROR)

project(recipe-05_core CXX)

find_package(message 1 CONFIG REQUIRED)
get_property(_loc TARGET message::message-shared PROPERTY LOCATION)
message(STATUS "Found message: ${_loc} (found version ${message_VERSION})")

add_executable(use_message use_message.cpp)
target_link_libraries(use_message
  PUBLIC
    message::message-shared
  )
