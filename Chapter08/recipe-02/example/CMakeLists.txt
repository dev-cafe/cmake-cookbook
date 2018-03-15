cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-02 LANGUAGES NONE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(colors)
define_colors()

message(STATUS "This is a normal message")
message(STATUS "${Red}This is a red status message${ColourReset}")
message(STATUS "${BoldRed}This is a bold red status message${ColourReset}")
message(STATUS "${Green}This is a green status message${ColourReset}")
message(STATUS "${BoldMagenta}This is a bold magenta status message${ColourReset}")
