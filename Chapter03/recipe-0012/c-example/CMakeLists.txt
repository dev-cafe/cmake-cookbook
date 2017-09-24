# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0012 C)

find_package(PythonLibs 2.7 QUIET REQUIRED)

add_executable(hello-embedded-python hello-embedded-python.c)
target_include_directories(hello-embedded-python
  PRIVATE
    ${PYTHON_INCLUDE_DIRS}
  )
target_link_libraries(hello-embedded-python
  PRIVATE
    ${PYTHON_LIBRARIES}
  )
