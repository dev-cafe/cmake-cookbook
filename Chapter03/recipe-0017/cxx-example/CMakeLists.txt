# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0017 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP REQUIRED)

find_package(Eigen3 3.3 REQUIRED NO_MODULE)
if(TARGET Eigen3::Eigen)
  message(STATUS "Eigen3 version ${EIGEN3_VERSION_STRING} found in ${EIGEN3_INCLUDE_DIR}")
endif()

find_package(BLAS)
find_package(LAPACK)

add_executable(linear-algebra linear-algebra.cpp)
if(BLAS_FOUND AND LAPACK_FOUND)
  message(STATUS "Eigen will use some subroutines from BLAS and LAPACK. See here: http://eigen.tuxfamily.org/dox-devel/TopicUsingBlasLapack.html")
  target_compile_definitions(linear-algebra
    PRIVATE
      EIGEN_USE_BLAS
      EIGEN_USE_LAPACKE_STRICT
    )
endif()
target_compile_options(linear-algebra
  PUBLIC
    ${OpenMP_CXX_FLAGS}
  )
target_link_libraries(linear-algebra
  PUBLIC
    Eigen3::Eigen
    ${BLAS_LIBRARIES}
    ${LAPACK_LIBRARIES}
  )
set_target_properties(linear-algebra
  PROPERTIES
    LINK_FLAGS ${OpenMP_CXX_FLAGS}
  )
