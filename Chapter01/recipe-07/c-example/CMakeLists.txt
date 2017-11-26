# set minimum cmake version
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

# project name and language
project(recipe-07 C)

message("Is the C++ compiler loaded? ${CMAKE_CXX_COMPILER_LOADED}")
if(CMAKE_CXX_COMPILER_LOADED)
  message("The C++ compiler ID is: ${CMAKE_CXX_COMPILER_ID}")
  message("Is the C++ from GNU? ${CMAKE_COMPILER_IS_GNUCXX}")
  message("The C++ compiler version is: ${CMAKE_CXX_COMPILER_VERSION}")
endif()

message("Is the C compiler loaded? ${CMAKE_C_COMPILER_LOADED}")
if(CMAKE_C_COMPILER_LOADED)
  message("The C compiler ID is: ${CMAKE_C_COMPILER_ID}")
  message("Is the C from GNU? ${CMAKE_COMPILER_IS_GNUCC}")
  message("The C compiler version is: ${CMAKE_C_COMPILER_VERSION}")
endif()

message("Is the Fortran compiler loaded? ${CMAKE_Fortran_COMPILER_LOADED}")
if(CMAKE_Fortran_COMPILER_LOADED)
  message("The Fortran compiler ID is: ${CMAKE_Fortran_COMPILER_ID}")
  message("Is the Fortran from GNU? ${CMAKE_COMPILER_IS_GNUG77}")
  message("The Fortran compiler version is: ${CMAKE_Fortran_COMPILER_VERSION}")
endif()

add_executable(hello-world hello-world.c)
