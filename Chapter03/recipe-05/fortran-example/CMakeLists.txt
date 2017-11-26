# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-05 Fortran)

find_package(OpenMP REQUIRED)

# We do this in a pedestrian way because the Fortran support is relatively recent
if(DEFINED CMAKE_Fortran_COMPILER_ID AND NOT DEFINED OpenMP_Fortran_FLAGS)
    if(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
        set(OpenMP_Fortran_FLAGS "-fopenmp")
    endif()
    if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
        if(WIN32)
            set(OpenMP_Fortran_FLAGS "-Qopenmp")
        elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "Intel" AND
               "${CMAKE_Fortran_COMPILER_VERSION}" VERSION_LESS "15.0.0.20140528")
            set(OpenMP_Fortran_FLAGS "-openmp")
        else()
            set(OpenMP_Fortran_FLAGS "-qopenmp")
        endif()
    endif()
    if(CMAKE_Fortran_COMPILER_ID MATCHES PGI)
        set(OpenMP_Fortran_FLAGS "-mp")
    endif()
    set(OPENMP_FOUND TRUE)
endif()

add_executable(dot_product dot_product.f90)
target_compile_options(dot_product
  PUBLIC
    ${OpenMP_Fortran_FLAGS}
  )
set_target_properties(dot_product
  PROPERTIES
    LINK_FLAGS ${OpenMP_Fortran_FLAGS}
  )
