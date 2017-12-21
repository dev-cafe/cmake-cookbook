cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-03 CXX)

# we require Python for this recipe to work
find_package(PythonInterp QUIET REQUIRED)

# upper bound
set(MAX_NUMBER "100" CACHE STRING "Upper bound for primes")

# generate directory where we place the generated code
file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated)

# generate code
add_custom_command(
  OUTPUT
    ${PROJECT_BINARY_DIR}/generated/primes.h
  COMMAND
    ${PYTHON_EXECUTABLE} generate.py ${MAX_NUMBER} ${PROJECT_BINARY_DIR}/generated/primes.h
  WORKING_DIRECTORY
    ${PROJECT_SOURCE_DIR}
  DEPENDS
    generate.py
  )

add_custom_target(
  generate
  ALL
  DEPENDS
    ${PROJECT_BINARY_DIR}/generated/primes.h
  )

add_executable(example.x example.cpp)

target_include_directories(
  example.x
  PRIVATE
  ${PROJECT_BINARY_DIR}/generated
  )

add_dependencies(example.x generate)
