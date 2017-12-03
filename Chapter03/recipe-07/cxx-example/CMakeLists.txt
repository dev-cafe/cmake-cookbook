cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(recipe-07 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP REQUIRED)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
if(TARGET Eigen3::Eigen)
  message(STATUS "Eigen3 version ${EIGEN3_VERSION_STRING} found in ${EIGEN3_INCLUDE_DIR}")
endif()

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra
  PUBLIC
    Eigen3::Eigen
    OpenMP::OpenMP_CXX
  )
