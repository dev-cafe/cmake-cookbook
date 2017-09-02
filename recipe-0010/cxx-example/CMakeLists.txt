# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-0010 CXX)

add_library(animals SHARED
  Animal.cpp
  Animal.hpp
  Cat.cpp
  Cat.hpp
  Dog.cpp
  Dog.hpp
  Factory.hpp
  )
set_target_properties(animals
  PROPERTIES
    CXX_STANDARD 14
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
    POSITION_INDEPENDENT_CODE 1
  )

add_executable(animal-farm animal-farm.cpp)
target_link_libraries(animal-farm animals)
# We want C++14, without compiler-specific extensions.
# Any standard lower than that will abort compilation.
set_target_properties(animal-farm
  PROPERTIES
    CXX_STANDARD 14
    CXX_EXTENSIONS OFF
    CXX_STANDARD_REQUIRED ON
  )
