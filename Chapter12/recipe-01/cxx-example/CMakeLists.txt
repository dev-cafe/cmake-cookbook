# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-01 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(sum_integers sum_integers.cpp)

add_executable(sum_up main.cpp)
target_link_libraries(sum_up sum_integers)

add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test sum_integers)

# define tests
enable_testing()
add_test(bash_test ${PROJECT_SOURCE_DIR}/test.sh)
add_test(cpp_test ${PROJECT_BINARY_DIR}/cpp_test)
add_test(python_test_long ${PROJECT_SOURCE_DIR}/test.py)
add_test(python_test_short ${PROJECT_SOURCE_DIR}/test.py --short)
