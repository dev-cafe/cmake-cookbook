# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name and language
project(recipe-01 Fortran)

add_executable(hello-world hello-world.f90)


include(CTest)
enable_testing()

add_test(unit_test ${PROJECT_SOURCE_DIR}/unit_test.sh)
