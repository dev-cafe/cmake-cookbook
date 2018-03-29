# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(recipe-01 LANGUAGES CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# example library
add_library(sum_integers sum_integers.cpp)

# main code
add_executable(sum_up main.cpp)
target_link_libraries(sum_up sum_integers)

# testing binary
add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test sum_integers)

# enable testing functionality
enable_testing()

# define tests
add_test(bash_test ${PROJECT_SOURCE_DIR}/test.sh)
add_test(cpp_test ${PROJECT_BINARY_DIR}/cpp_test)
add_test(python_test_long ${PROJECT_SOURCE_DIR}/test.py)
add_test(python_test_short ${PROJECT_SOURCE_DIR}/test.py --short)
