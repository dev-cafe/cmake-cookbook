# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-0008 CXX)

message("Build type: ${CMAKE_BUILD_TYPE}")
message("Configuration types: ${CMAKE_CONFIGURATION_TYPES}")
message("C++ compiler flags: ${CMAKE_CXX_FLAGS}")
message("C++ compiler flags, debug mode: ${CMAKE_CXX_FLAGS_DEBUG}")
message("C++ compiler flags, relese mode: ${CMAKE_CXX_FLAGS_RELEASE}")
message("C++ compiler flags, release with debug info mode: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message("C++ compiler flags, minimal release mode: ${CMAKE_CXX_FLAGS_MINSIZEREL}")

add_executable(inplace_expression_validity inplace_expression_validity.cpp)
# We would like C++14, without compiler-specific extensions.
# Any standard lower than that will abort compilation.
set_target_properties(inplace_expression_validity
  PROPERTIES
    CXX_STANDARD 14
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
  )
