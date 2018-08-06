cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-03_core LANGUAGES C)

find_package(FFTW3 CONFIG REQUIRED)
get_property(_loc TARGET FFTW3::fftw3 PROPERTY LOCATION)
message(STATUS "Found FFTW3: ${_loc} (found version ${FFTW3_VERSION})")

add_executable(fftw_example fftw_example.c)

target_link_libraries(fftw_example
  PRIVATE
    FFTW3::fftw3
  )
