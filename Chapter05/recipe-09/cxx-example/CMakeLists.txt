cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

project(recipe-09 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CXX_BASIC_FLAGS "-g3 -O2")
string(REPLACE " " ";" _cxx_basic_flags ${CXX_BASIC_FLAGS})

include(CheckCXXCompilerFlag)

set(ASAN_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
string(REPLACE " " ";" _asan_flags ${ASAN_FLAGS})
set(CMAKE_REQUIRED_FLAGS ${ASAN_FLAGS})
check_cxx_compiler_flag(${ASAN_FLAGS} asan_works)
unset(CMAKE_REQUIRED_FLAGS)

add_executable(asan-example asan-example.cpp)
target_compile_options(asan-example
  PUBLIC
    ${_cxx_basic_flags}
    $<$<BOOL:${asan_works}>:${_asan_flags}>
  )
target_link_libraries(asan-example
  PUBLIC
    $<$<BOOL:${asan_works}>:asan>
  )
