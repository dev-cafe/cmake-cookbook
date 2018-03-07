cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-04_core CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP REQUIRED)

find_package(Eigen3 3.3.4 REQUIRED NO_MODULE)
message(STATUS "Found Eigen3: ${EIGEN3_INCLUDE_DIR} (found version ${EIGEN3_VERSION_STRING})")

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PUBLIC
    Eigen3::Eigen
    OpenMP::OpenMP_CXX
  )

install(
  PROGRAMS
    ${CMAKE_BINARY_DIR}/linear-algebra
  DESTINATION
    ${CMAKE_INSTALL_PREFIX}/bin
  )
