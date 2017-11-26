# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-04 CXX)

# expose options to the user
option(USE_LIBRARY "Compile sources into a library" OFF)

include(CMakeDependentOption)
# second option depends on the value of the first
cmake_dependent_option(MAKE_STATIC_LIBRARY "Compile sources into a static library" OFF
                       "USE_LIBRARY" ON)
# third option depends on the value of the first
cmake_dependent_option(MAKE_SHARED_LIBRARY "Compile sources into a shared library" ON
                       "USE_LIBRARY" ON)

# list sources
set(_sources Message.hpp Message.cpp)

message(STATUS "Compile sources into a library? ${USE_LIBRARY}")

if(USE_LIBRARY)
  message(STATUS "Compile sources into a STATIC library? ${MAKE_STATIC_LIBRARY}")
  message(STATUS "Compile sources into a SHARED library? ${MAKE_SHARED_LIBRARY}")
  if(MAKE_SHARED_LIBRARY)
    add_library(message SHARED ${_sources})

    add_executable(hello-world hello-world.cpp)

    target_link_libraries(hello-world message)
  endif()
  if(MAKE_STATIC_LIBRARY)
    add_library(message STATIC ${_sources})

    add_executable(hello-world hello-world.cpp)

    target_link_libraries(hello-world message)
  endif()
else()
  add_executable(hello-world hello-world.cpp ${_sources})
endif()
