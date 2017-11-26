# set minimum cmake version
cmake_minimum_required(VERSION 3.7 FATAL_ERROR)

# project name
project(recipe-10)

# define tests
enable_testing()

add_test(setup ${PROJECT_SOURCE_DIR}/test/setup.sh)
set_tests_properties(
    setup
    PROPERTIES
      FIXTURES_SETUP my-fixture
    )

add_test(feature-a ${PROJECT_SOURCE_DIR}/test/feature-a.sh)
add_test(feature-b ${PROJECT_SOURCE_DIR}/test/feature-b.sh)
set_tests_properties(
    feature-a
    feature-b
    PROPERTIES
      FIXTURES_REQUIRED my-fixture
    )

add_test(cleanup ${PROJECT_SOURCE_DIR}/test/cleanup.sh)
set_tests_properties(
    cleanup
    PROPERTIES
      FIXTURES_CLEANUP my-fixture
    )
