# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-05 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# name of the executable
add_executable(dgemm-example "")

# its sources
target_sources(dgemm-example
  PRIVATE
    example.cpp
  )

# we mimick the include directories, compiler options, and link line suggested by the advisor:
# https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/
add_library(IntelMKL INTERFACE)

# its compile options
target_compile_options(IntelMKL
  INTERFACE
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:AppleClang>>:-m64>
  )

# locate mkl.h
find_path(_mkl_h
  NAMES
    mkl.h
  HINTS
    ${CMAKE_INSTALL_PREFIX}/include
  )
target_include_directories(IntelMKL
  INTERFACE
    ${_mkl_h}
  )
message(STATUS "MKL header file FOUND: ${_mkl_h}")

# locate MKL single dynamic library (mkl_rt)
find_library(_mkl_libs
  NAMES
    mkl_rt
  HINTS
    ${CMAKE_INSTALL_PREFIX}/lib
  )
message(STATUS "MKL single dynamic library FOUND: ${_mkl_libs}")

find_package(Threads QUIET)
target_link_libraries(IntelMKL
  INTERFACE
    ${_mkl_libs}
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:AppleClang>>:Threads::Threads>
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:AppleClang>>:m>
  )

include(CMakePrintHelpers)
cmake_print_properties(
  TARGETS
    IntelMKL
  PROPERTIES
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_LINK_LIBRARIES
  )

# link to MKL libraries
target_link_libraries(dgemm-example
  PRIVATE
    IntelMKL
  )

# install the binary
install(
  TARGETS
    dgemm-example
  DESTINATION
    bin
  )
