cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-06 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
if(TARGET Eigen3::Eigen)
  message(STATUS "Eigen3 version ${EIGEN3_VERSION_STRING} found in ${EIGEN3_INCLUDE_DIR}")
endif()

include(CheckCXXCompilerFlag)
check_cxx_compiler_flag("-march=native" _march_native_works)
check_cxx_compiler_flag("-xHost" _xhost_works)
set(${PROJECT_NAME}_CXX_FLAGS)
if(_march_native_works)
  message(STATUS "Using processor's vector instructions (-march=native compiler flag set)")
  set(${PROJECT_NAME}_CXX_FLAGS "-march=native")
elseif(_xhost_works)
  message(STATUS "Using processor's vector instructions (-xHost compiler flag set)")
  set(${PROJECT_NAME}_CXX_FLAGS "-xHost")
else()
  message(STATUS "No suitable compiler flag found for vectorization")
endif()

add_executable(linear-algebra linear-algebra.cpp)
target_compile_options(linear-algebra
  PRIVATE
    ${${PROJECT_NAME}_CXX_FLAGS}
    -save-temps
  )
target_link_libraries(linear-algebra
  PRIVATE
    Eigen3::Eigen
  )
