cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

project(recipe-07 CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CXX_BASIC_FLAGS "-g3 -O2")
include(CheckCXXCompilerFlag)

set(ASAN_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
set(CMAKE_REQUIRED_FLAGS ${ASAN_FLAGS})
check_cxx_compiler_flag(${ASAN_FLAGS} asan_works)
if(asan_works)
add_executable(asan-example asan-example.cpp)
target_compile_options(asan-example
  PUBLIC
    -g3 -O2 -fsanitize=address -fno-omit-frame-pointer
  )
target_link_libraries(asan-example
  PUBLIC
    asan
  )
endif()

find_package(Threads REQUIRED)
add_executable(tsan-example tsan-example.cpp)
target_compile_options(tsan-example
  PUBLIC
    ${CXX_BASIC_FLAGS} ${TSAN_FLAGS}
  )
target_link_libraries(tsan-example
  PUBLIC
    Threads::Threads
  )

add_executable(msan-example msan-example.cpp)
target_compile_options(msan-example
  PUBLIC
    ${CXX_BASIC_FLAGS} ${MSAN_FLAGS}
  )

add_executable(ubsan-example ubsan-example.cpp)
target_compile_options(ubsan-example
  PUBLIC
    ${CXX_BASIC_FLAGS} ${UBSAN_FLAGS}
  )
