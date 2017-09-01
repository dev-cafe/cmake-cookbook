# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-0009 CXX)

add_executable(inplace_expression_validity inplace_expression_validity.cpp)
# We would like C++11, without compiler-specific extensions.
# Any standard lower than that will abort compilation.
set_target_properties(inplace_expression_validity
  PROPERTIES
    CXX_STANDARD 11
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
  )
