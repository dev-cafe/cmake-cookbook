cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-03 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# we require Python for this recipe to work
find_package(PythonInterp QUIET REQUIRED)

# generate directory where we place the generated code
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/generated)

# upper bound
set(MAX_NUMBER "100" CACHE STRING "Upper bound for primes")

# generate code
add_custom_command(
  OUTPUT
    ${CMAKE_CURRENT_BINARY_DIR}/generated/primes.hpp
  COMMAND
    ${PYTHON_EXECUTABLE} generate.py ${MAX_NUMBER} ${CMAKE_CURRENT_BINARY_DIR}/generated/primes.hpp
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS
    generate.py
  )

add_executable(example "")

target_sources(example
  PRIVATE
    example.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/generated/primes.hpp
  )

target_include_directories(example
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/generated
  )
