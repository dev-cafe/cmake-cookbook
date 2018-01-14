cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-03 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# User options:
# FORCE_CUSTOM_BOOST

find_package(PythonInterp REQUIRED)
find_package(PythonLibs REQUIRED)

set(BOOST_MINIMUM_REQUIRED 1.59.0)
string(REGEX REPLACE "\\." "_" BOOSTVER ${BOOST_MINIMUM_REQUIRED})
set(BOOST_ARCHIVE_LOCATION ${PROJECT_SOURCE_DIR})
set(BOOST_ARCHIVE boost_${BOOSTVER}.tar.gz)
# What kind of Boost we want
set(Boost_USE_STATIC_LIBS    ON)
set(Boost_USE_MULTITHREADED  ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(Boost_DEBUG OFF)
set(Boost_DETAILED_FAILURE_MESSAGE OFF)

list(APPEND BOOST_COMPONENTS_REQUIRED filesystem system python)
set(BUILD_CUSTOM_BOOST FALSE)
if(FORCE_CUSTOM_BOOST)
  set(BUILD_CUSTOM_BOOST TRUE)
  message(STATUS "Force automatic build of Boost")
  # Just to avoid unused variable warning from CMake
  set(BOOST_INCLUDEDIR "")
  set(BOOST_LIBRARYDIR "")
else()
  # Read from cache, needed for rebuilds
  set(BOOST_INCLUDEDIR ${Boost_INCLUDE_DIR})
  set(BOOST_LIBRARYDIR ${Boost_LIBRARY_DIR})
  find_package(Boost ${BOOST_MINIMUM_REQUIRED} COMPONENTS "${BOOST_COMPONENTS_REQUIRED}")
  if(NOT Boost_FOUND)
    set(BUILD_CUSTOM_BOOST TRUE)
  endif()
endif()

if(BUILD_CUSTOM_BOOST)
  ## Preliminary work
  # 0. Root directory for the custom build
  set(CUSTOM_BOOST_LOCATION ${PROJECT_BINARY_DIR}/boost)
  file(MAKE_DIRECTORY ${CUSTOM_BOOST_LOCATION})
  # 1. Where Boost will be built
  set(BOOST_BUILD_DIR ${CUSTOM_BOOST_LOCATION}/boost_${BOOSTVER})
  # 2. Select toolset according to compilers specified by the user
  if(CMAKE_CXX_COMPILER_ID MATCHES Intel)
      set(toolset "intel-linux")
  elseif(CMAKE_CXX_COMPILER_ID MATCHES Clang)
      set(toolset "clang")
  else()
      if(CMAKE_SYSTEM_NAME MATCHES Darwin)
          set(toolset "darwin")
      else()
          set(toolset "gcc")
      endif()
  endif()

  if(NOT DEFINED CMAKE_BUILD_TYPE OR "${CMAKE_BUILD_TYPE}" STREQUAL "")
    set(type "release")
  endif()

  include(${CMAKE_CURRENT_LIST_DIR}/boost_unpack.cmake)
  include(${CMAKE_CURRENT_LIST_DIR}/boost_userconfig.cmake)

  if(NOT "${BOOST_COMPONENTS_REQUIRED}" STREQUAL "")
    # Non-empty list. Compiled libraries needed
    # Transform the ;-separated list to a ,-separated list (digested by the Boost build toolchain!)
    string(REPLACE ";" "," b2_needed_components "${BOOST_COMPONENTS_REQUIRED}")
    # Replace unit_test_framework (used by CMake's find_package) with test (understood by Boost build toolchain)
    string(REPLACE "unit_test_framework" "test" b2_needed_components "${b2_needed_components}")
    set(select_libraries "--with-libraries=${b2_needed_components}")
    string(REPLACE ";" ", " printout "${BOOST_COMPONENTS_REQUIRED}")
    message(STATUS "  Libraries to be built: ${printout}")
    message(STATUS "  Toolset to be used: ${toolset}")
    include(${CMAKE_CURRENT_LIST_DIR}/boost_configure.cmake)
    include(${CMAKE_CURRENT_LIST_DIR}/boost_build.cmake)
    include(${CMAKE_CURRENT_LIST_DIR}/boost_install.cmake)
  else()
    # Empty list. Header-only libraries needed
    # Just unpack to known location
    message(STATUS "  No libraries required, installing headers")
    include(${CMAKE_CURRENT_LIST_DIR}/boost_headers.cmake)
  endif()

  include(${CMAKE_CURRENT_LIST_DIR}/boost_cleanup.cmake)
  add_custom_target(custom_boost DEPENDS ${CUSTOM_BOOST_LOCATION}/boost.cleanedup)
  # 4. Set all variables related to Boost that find_package would have set
  set(Boost_FOUND TRUE)
  string(REGEX REPLACE "\\." "0" Boost_VERSION ${BOOST_MINIMUM_REQUIRED})
  math(EXPR Boost_MAJOR_VERSION "${Boost_VERSION} / 100000")
  math(EXPR Boost_MINOR_VERSION "${Boost_VERSION} / 100 % 1000")
  math(EXPR Boost_SUBMINOR_VERSION "${Boost_VERSION} % 100")
  set(Boost_LIB_VERSION ${Boost_MAJOR_VERSION}_${Boost_MINOR_VERSION})
  set(Boost_INCLUDE_DIR ${CUSTOM_BOOST_LOCATION}/include CACHE PATH "Boost include directory" FORCE)
  set(Boost_LIBRARY_DIR ${CUSTOM_BOOST_LOCATION}/lib CACHE PATH "Boost library directory" FORCE)

  foreach(_component ${BOOST_COMPONENTS_REQUIRED})
    string(TOUPPER ${_component} _COMP)
    set(Boost_${_COMP}_FOUND TRUE)
    set(Boost_${_COMP}_LIBRARY ${Boost_LIBRARY_DIR}/libboost_${_component}.a)
    set(Boost_${_COMP}_LIBRARY_DEBUG ${Boost_LIBRARY_DIR}/${Boost_${_COMP}_LIBRARY} CACHE FILEPATH "Boost ${_component} library (debug)" FORCE)
    set(Boost_${_COMP}_LIBRARY_RELEASE ${Boost_LIBRARY_DIR}/${Boost_${_COMP}_LIBRARY} CACHE FILEPATH "Boost ${_component} library (release)" FORCE)
    list(APPEND Boost_LIBRARIES ${Boost_${_COMP}_LIBRARY})
  endforeach()

  set(Boost_INCLUDE_DIRS ${Boost_INCLUDE_DIR})
  set(Boost_LIBRARY_DIRS ${Boost_LIBRARY_DIR})
  if(CMAKE_SYSTEM_NAME MATCHES Linux)
    list(APPEND Boost_LIBRARIES rt)
  endif()
endif()

add_executable(path-info path-info.cpp)
if(BUILD_CUSTOM_BOOST)
  add_dependencies(path-info custom_boost)
endif()
target_include_directories(path-info
  SYSTEM
  PUBLIC
    ${Boost_INCLUDE_DIRS}
  )
target_link_libraries(path-info
  PUBLIC
    ${Boost_LIBRARIES}
  )
