# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-02 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PythonInterp 2.7 REQUIRED)
find_package(PythonLibs 2.7 REQUIRED)

# Find NumPy version
execute_process(
  COMMAND
    ${PYTHON_EXECUTABLE} "-c" "import re, numpy; print(re.compile('/__init__.py.*').sub('',numpy.__version__))"
  OUTPUT_VARIABLE NumPy_VERSION
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
message(STATUS "NumPy version: ${NumPy_VERSION}")
configure_file(Report.hpp.in Report.hpp @ONLY)

add_executable(pure-embedding pure-embedding.cpp)
target_include_directories(pure-embedding
  PRIVATE
    ${PYTHON_INCLUDE_DIRS}
    ${PROJECT_BINARY_DIR}
  )
target_link_libraries(pure-embedding
  PRIVATE
    ${PYTHON_LIBRARIES}
  )
file(COPY ${PROJECT_SOURCE_DIR}/use_numpy.py
     DESTINATION ${PROJECT_BINARY_DIR}
    )
