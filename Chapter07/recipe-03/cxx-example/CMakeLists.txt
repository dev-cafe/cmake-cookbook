cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-03 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(ExternalProject)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "/usr/local/${PROJECT_NAME}" CACHE PATH "Install path" FORCE)
endif()
message(STATUS "${PROJECT_NAME} install: ${CMAKE_INSTALL_PREFIX}")
set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage${CMAKE_INSTALL_PREFIX})
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")

set(Boost_USE_STATIC_LIBS    OFF)
set(Boost_USE_MULTITHREADED  ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(Boost_DEBUG OFF)
set(Boost_DETAILED_FAILURE_MESSAGE OFF)
list(APPEND BOOST_COMPONENTS_REQUIRED filesystem system)
find_package(Boost 1.64.0 COMPONENTS "${BOOST_COMPONENTS_REQUIRED}" QUIET)
if(Boost_FOUND)
  message(STATUS "Found Boost: ${Boost_LIBRARY_DIRS} (found version ${Boost_VERSION})")
  add_library(custom_boost INTERFACE)
else()
  message(STATUS "Suitable Boost could not be located. Downloading and building!")

  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    if(APPLE)
      set(toolset "darwin")
    else()
      set(toolset "gcc")
    endif()
  elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
    set(toolset "clang")
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "Intel")
    set(toolset "intel")
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    set(toolset "msvc")
  endif()

  if(WIN32)
    set(Boost_BOOTSTRAP "bootstrap.bat")
  else()
    set(Boost_BOOTSTRAP "bootstrap.sh")
  endif()

  if(NOT "${BOOST_COMPONENTS_REQUIRED}" STREQUAL "")
    # Non-empty list. Compiled libraries needed
    # Transform the ;-separated list to a ,-separated list (digested by the Boost build toolchain!)
    string(REPLACE ";" "," b2_needed_components "${BOOST_COMPONENTS_REQUIRED}")
    # Replace unit_test_framework (used by CMake's find_package) with test (understood by Boost build toolchain)
    string(REPLACE "unit_test_framework" "test" b2_needed_components "${b2_needed_components}")
    set(select_libraries "--with-libraries=${b2_needed_components}")
    string(REPLACE ";" ", " printout "${BOOST_COMPONENTS_REQUIRED}")
    message(STATUS "  Libraries to be built: ${printout}")
  endif()

  set(Boost_USER_CONFIG_JAMFILE "${PROJECT_BINARY_DIR}/user-config.jam")
  file(WRITE "${Boost_USER_CONFIG_JAMFILE}" "using ${toolset} : : ${CMAKE_CXX_COMPILER} : <cxxflags>\"-std=c++11\" <linkflags>\"-std=c++11\" ;")
  set(Boost_BUILD_USER_CONFIG_ARGS "--user-config=${PROJECT_BINARY_DIR}/user-config.jam")

  ExternalProject_Add(custom_boost
    PREFIX
      external
    URL
      https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.zip
    URL_HASH
      SHA256=b99973c805f38b549dbeaf88701c0abeff8b0e8eaa4066df47cac10a32097523
    DOWNLOAD_NO_PROGRESS
      1
    UPDATE_COMMAND
      ""
    BUILD_IN_SOURCE
      1
    CONFIGURE_COMMAND
      <SOURCE_DIR>/${Boost_BOOTSTRAP}
      --with-toolset=${toolset}
      --prefix=${STAGED_INSTALL_PREFIX}/boost
      ${select_libraries}
    BUILD_COMMAND
      ""
    INSTALL_COMMAND
      <SOURCE_DIR>/b2 -q install
           link=shared
           threading=multi
           variant=release
           toolset=${toolset}
           ${Boost_BUILD_USER_CONFIG_ARGS}
    LOG_BUILD
      1
    LOG_INSTALL
      1
    STEP_TARGETS
      download update configure install
    BUILD_BYPRODUCTS
      ${STAGED_INSTALL_PREFIX}/boost/lib/libboost_system${CMAKE_SHARED_LIBRARY_SUFFIX}
      ${STAGED_INSTALL_PREFIX}/boost/lib/libboost_filesystem${CMAKE_SHARED_LIBRARY_SUFFIX}
    )

  # Set all variables related to Boost that find_package would have set
   set(Boost_FOUND TRUE)
   set(Boost_MAJOR_VERSION 1)
   set(Boost_MINOR_VERSION 64)
   set(Boost_SUBMINOR_VERSION 0)
   set(Boost_LIB_VERSION ${Boost_MAJOR_VERSION}_${Boost_MINOR_VERSION})
   set(Boost_INCLUDE_DIR ${STAGED_INSTALL_PREFIX}/boost/include CACHE PATH "Boost include directory" FORCE)
   set(Boost_LIBRARY_DIR ${STAGED_INSTALL_PREFIX}/boost/lib CACHE PATH "Boost library directory" FORCE)

   foreach(_component ${BOOST_COMPONENTS_REQUIRED})
     string(TOUPPER ${_component} _COMP)
     set(Boost_${_COMP}_FOUND TRUE)
     set(Boost_${_COMP}_LIBRARY ${Boost_LIBRARY_DIR}/libboost_${_component}${CMAKE_SHARED_LIBRARY_SUFFIX})
     set(Boost_${_COMP}_LIBRARY_DEBUG ${Boost_LIBRARY_DIR}/${Boost_${_COMP}_LIBRARY} CACHE FILEPATH "Boost ${_component} library (debug)" FORCE)
     set(Boost_${_COMP}_LIBRARY_RELEASE ${Boost_LIBRARY_DIR}/${Boost_${_COMP}_LIBRARY} CACHE FILEPATH "Boost ${_component} library (release)" FORCE)
     list(APPEND Boost_LIBRARIES ${Boost_${_COMP}_LIBRARY})
   endforeach()

   set(Boost_INCLUDE_DIRS ${Boost_INCLUDE_DIR})
   set(Boost_LIBRARY_DIRS ${Boost_LIBRARY_DIR})
endif()

add_executable(path-info path-info.cpp)
add_dependencies(path-info custom_boost)
target_include_directories(path-info
  SYSTEM
  PUBLIC
    ${Boost_INCLUDE_DIRS}
  )
target_link_libraries(path-info
  PUBLIC
    ${Boost_LIBRARIES}
  )
