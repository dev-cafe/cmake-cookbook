# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0013 CXX)

# let the preprocessor know about the compiler vendor
if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
    add_definitions(-DIS_INTEL_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    add_definitions(-DIS_GNU_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES PGI)
    add_definitions(-DIS_PGI_COMPILER)
endif()
if(CMAKE_CXX_COMPILER_ID MATCHES XL)
    add_definitions(-DIS_XL_COMPILER)
endif()
# etc ...

# define executable and its source file
add_executable(hello-world hello-world.cpp)
