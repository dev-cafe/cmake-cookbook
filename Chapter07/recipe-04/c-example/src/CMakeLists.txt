cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(fftw_example C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(FFTW3 CONFIG REQUIRED)

add_executable(fftw_example fftw_example.c)
target_include_directories(fftw_example
  SYSTEM
  PRIVATE
    ${FFTW3_INCLUDE_DIRS}
  )
target_link_libraries(fftw_example
  PRIVATE
    FFTW3::fftw3
  )

install(
  PROGRAMS
    ${CMAKE_BINARY_DIR}/fftw_example
  DESTINATION
    ${CMAKE_INSTALL_PREFIX}/bin
  )
