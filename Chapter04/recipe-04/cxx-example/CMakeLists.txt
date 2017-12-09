# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-04 CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# example library
add_library(sum_integers sum_integers.cpp)

# main code
add_executable(sum_up main.cpp)
target_link_libraries(sum_up sum_integers)

# find boost library
find_package(Boost 1.54 REQUIRED COMPONENTS unit_test_framework)

add_executable(cpp_test test.cpp)

target_include_directories(
  cpp_test
  PRIVATE
  ${Boost_INCLUDE_DIRS}
  )

# avoid undefined reference to "main" in test.cpp
target_compile_definitions(
  cpp_test
  PRIVATE
  -DBOOST_TEST_DYN_LINK
  )

target_link_libraries(
  cpp_test
  sum_integers
  ${Boost_LIBRARIES}
  )

enable_testing()
add_test(boost_test ${PROJECT_BINARY_DIR}/cpp_test)
