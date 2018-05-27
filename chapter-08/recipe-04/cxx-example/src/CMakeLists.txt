cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

project(recipe-04_core LANGUAGES CXX)

find_package(OpenMP REQUIRED)

find_package(Eigen3 3.3.4 REQUIRED CONFIG)
message(STATUS "Found Eigen3: ${EIGEN3_INCLUDE_DIR} (found version ${EIGEN3_VERSION_STRING})")

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PUBLIC
    Eigen3::Eigen
    OpenMP::OpenMP_CXX
  )
