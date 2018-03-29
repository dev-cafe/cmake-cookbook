# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name
project(recipe-07 LANGUAGES NONE)

# define tests
enable_testing()

# we expect this test to run for 2 seconds
add_test(example ${PROJECT_SOURCE_DIR}/test.sh)

# timeout for this test set to 10 seconds
set_tests_properties(example PROPERTIES TIMEOUT 10)
