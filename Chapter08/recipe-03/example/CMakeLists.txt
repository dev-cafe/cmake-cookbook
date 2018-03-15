cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-03 LANGUAGES C CXX)

include(set_compiler_flag.cmake)

set_compiler_flag(
  working_compile_flag C REQUIRED
  "-foo"       # this should fail
  "-wrong"     # this should fail
  "-wrong"     # this should fail
  "-Wall"      # this should work with GNU
  "-warn all"  # this should work with Intel
  "-nope"      # this should fail
  )

message(STATUS "this is a working compile flag: ${working_compile_flag}")

set_compiler_flag(
  working_compile_flag CXX REQUIRED
  "-foo"  # this should fail
  "-g"    # this should work
  )

message(STATUS "this is a working compile flag: ${working_compile_flag}")
