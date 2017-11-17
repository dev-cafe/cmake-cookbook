# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-01 CXX)

# define executable and its dependencies
add_executable(replicate replicate.cpp)

enable_testing()

# define two tests
add_test(bash_test ${PROJECT_SOURCE_DIR}/test.sh)
add_test(python_test ${PROJECT_SOURCE_DIR}/test.py)
