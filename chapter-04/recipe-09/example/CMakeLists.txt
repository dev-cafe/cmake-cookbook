# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name
project(recipe-09 LANGUAGES NONE)

# detect python
find_package(PythonInterp REQUIRED)

# define tests
enable_testing()

add_test(feature-a ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-a.py)
add_test(feature-b ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-b.py)
add_test(feature-c ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-c.py)
add_test(feature-d ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-d.py)

add_test(benchmark-a ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/benchmark-a.py)
add_test(benchmark-b ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/benchmark-b.py)

set_tests_properties(
  feature-a
  feature-b
  feature-c
  PROPERTIES
    LABELS "quick"
  )

set_tests_properties(
  feature-d
  benchmark-a
  benchmark-b
  PROPERTIES
    LABELS "long"
  )
