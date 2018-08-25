# define minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and supported language
project(recipe-04 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# we default to Release build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# for testing we will need the python interpreter
find_package(PythonInterp REQUIRED)

# we require python development headers
find_package(PythonLibs ${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR} EXACT REQUIRED)

# now search for the boost component
# depending on the boost version it is called either python,
# python2, python27, python3, python36, python37, ...

list(
  APPEND _components
    python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}
    python${PYTHON_VERSION_MAJOR}
    python
  )

set(_boost_component_found "")

foreach(_component IN ITEMS ${_components})
  find_package(Boost COMPONENTS ${_component})
  if(Boost_FOUND)
    set(_boost_component_found ${_component})
    break()
  endif()
endforeach()

if(_boost_component_found STREQUAL "")
  message(FATAL_ERROR "No matching Boost.Python component found")
endif()

# create python module
add_library(account
  MODULE
    account.cpp
  )

target_link_libraries(account
  PUBLIC
    Boost::${_boost_component_found}
    ${PYTHON_LIBRARIES}
  )

target_include_directories(account
  PRIVATE
    ${PYTHON_INCLUDE_DIRS}
  )

# prevent cmake from creating a "lib" prefix
set_target_properties(account
  PROPERTIES
    PREFIX ""
  )

if(WIN32)
  # python will not import dll but expects pyd
  set_target_properties(account
    PROPERTIES
      SUFFIX ".pyd"
    )
endif()

# turn on testing
enable_testing()

# define test
add_test(
  NAME
    python_test
  COMMAND
    ${CMAKE_COMMAND} -E env ACCOUNT_MODULE_PATH=$<TARGET_FILE_DIR:account>
    ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/test.py
  )
