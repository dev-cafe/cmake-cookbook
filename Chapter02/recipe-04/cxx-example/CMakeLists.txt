# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-04 CXX)

# define executable and its source file
add_executable(arch-dependent arch-dependent.cpp)

# let the preprocessor know about the host processor architecture
if(CMAKE_HOST_SYSTEM_PROCESSOR
   MATCHES
   "i386"
   OR
   CMAKE_HOST_SYSTEM_PROCESSOR
   MATCHES
   "i686")
  target_compile_definitions(arch-dependent PUBLIC "-DIS_32_BIT_ARCH")
  message(STATUS "32 bit host processor architecture detected")
elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "x86_64")
  target_compile_definitions(arch-dependent PUBLIC "-DIS_64_BIT_ARCH")
  message(STATUS "64 bit host processor architecture detected")
else()
  message(
    STATUS
      "host processor architecture is unknown and no preprocessor flag set")
endif()
