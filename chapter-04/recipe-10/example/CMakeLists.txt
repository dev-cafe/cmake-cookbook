# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name
project(recipe-10 LANGUAGES NONE)

# detect python
find_package(PythonInterp REQUIRED)

# define tests
enable_testing()

add_test(setup ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/setup.py)
set_tests_properties(
  setup
  PROPERTIES
    FIXTURES_SETUP my-fixture
  )

add_test(feature-a ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-a.py)
add_test(feature-b ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/feature-b.py)
set_tests_properties(
  feature-a
  feature-b
  PROPERTIES
    FIXTURES_REQUIRED my-fixture
  )

add_test(cleanup ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test/cleanup.py)
set_tests_properties(
  cleanup
  PROPERTIES
    FIXTURES_CLEANUP my-fixture
  )
