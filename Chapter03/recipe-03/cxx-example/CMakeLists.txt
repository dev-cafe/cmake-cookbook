# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-03 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PythonInterp 2.7 REQUIRED)
find_package(PythonLibs 2.7 REQUIRED)

# Find NumPy location
execute_process(
  COMMAND
    ${PYTHON_EXECUTABLE} "-c" "import re, numpy; print(re.compile('/__init__.py.*').sub('',numpy.__file__))"
  RESULT_VARIABLE _numpy_status
  OUTPUT_VARIABLE _numpy_location
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
if(NOT _numpy_status)
  set(NumPy ${_numpy_location} CACHE STRING "Location of Python module NumPy")
endif()
# Find NumPy version
execute_process(
  COMMAND
    ${PYTHON_EXECUTABLE} "-c" "import re, numpy; print(re.compile('/__init__.py.*').sub('',numpy.__version__))"
  OUTPUT_VARIABLE _numpy_version
  ERROR_QUIET
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NumPy
  FOUND_VAR NumPy_FOUND
  REQUIRED_VARS NumPy
  VERSION_VAR _numpy_version
  )

add_executable(pure-embedding "")
if (PYTHON_VERSION_MAJOR VERSION_LESS 3)
  target_sources(pure-embedding
    PRIVATE
      Py2-pure-embedding.cpp
    )
else()
  target_sources(pure-embedding
    PRIVATE
      Py3-pure-embedding.cpp
    )
endif()
target_include_directories(pure-embedding
  PRIVATE
    ${PYTHON_INCLUDE_DIRS}
  )
target_link_libraries(pure-embedding
  PRIVATE
    ${PYTHON_LIBRARIES}
  )
file(COPY ${PROJECT_SOURCE_DIR}/use_numpy.py
     DESTINATION ${PROJECT_BINARY_DIR}
    )
