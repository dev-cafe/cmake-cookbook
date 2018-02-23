# define minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and supported language
project(recipe-06 CXX)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# interface and sources
add_subdirectory(account)

# turn on testing
enable_testing()

# require python
find_package(PythonInterp REQUIRED)

# define test
add_test(python_test ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/test.py)

# export environment variables needed by the test
set_property(TEST python_test
             PROPERTY ENVIRONMENT ACCOUNT_LIBRARY_DIR=${PROJECT_BINARY_DIR}/lib
                      ACCOUNT_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/account)
