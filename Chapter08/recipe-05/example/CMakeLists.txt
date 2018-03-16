cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-05 LANGUAGES NONE)

# (re)defines include_guard
include(cmake/include_guard.cmake)

# this is some custom module
include(cmake/custom.cmake)

# we simulate that we accidentally include the module a second time
include(cmake/custom.cmake)
