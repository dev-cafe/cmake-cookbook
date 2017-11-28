# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name
project(recipe-09)

# define tests
enable_testing()

add_test(feature-a ${PROJECT_SOURCE_DIR}/test/feature-a.sh)
add_test(feature-b ${PROJECT_SOURCE_DIR}/test/feature-b.sh)
add_test(feature-c ${PROJECT_SOURCE_DIR}/test/feature-c.sh)
add_test(feature-d ${PROJECT_SOURCE_DIR}/test/feature-d.sh)

add_test(benchmark-a ${PROJECT_SOURCE_DIR}/test/benchmark-a.sh)
add_test(benchmark-b ${PROJECT_SOURCE_DIR}/test/benchmark-b.sh)

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
