cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(recipe-07 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CXX_BASIC_FLAGS "-g3" "-O1")

include(CheckCXXCompilerFlag)

set(ASAN_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
set(CMAKE_REQUIRED_FLAGS ${ASAN_FLAGS})
check_cxx_compiler_flag(${ASAN_FLAGS} asan_works)
unset(CMAKE_REQUIRED_FLAGS)
if(asan_works)
  string(REPLACE " " ";" _asan_flags ${ASAN_FLAGS})
  add_executable(asan-example asan-example.cpp)
  target_compile_options(asan-example
    PUBLIC
      ${CXX_BASIC_FLAGS}
      ${_asan_flags}
    )
  target_link_libraries(asan-example
    PUBLIC
      ${_asan_flags}
    )
endif()

set(TSAN_FLAGS "-fsanitize=thread -fno-omit-frame-pointer -fPIE")
set(CMAKE_REQUIRED_FLAGS ${TSAN_FLAGS})
check_cxx_compiler_flag(${TSAN_FLAGS} tsan_works)
unset(CMAKE_REQUIRED_FLAGS)
if(tsan_works)
  string(REPLACE " " ";" _tsan_flags ${TSAN_FLAGS})
  find_package(Threads REQUIRED)
  add_executable(tsan-example tsan-example.cpp)
  target_compile_options(tsan-example
    PUBLIC
      ${CXX_BASIC_FLAGS}
      ${_tsan_flags}
    )
  target_link_libraries(tsan-example
    PUBLIC
      Threads::Threads
      ${_tsan_flags}
      -pie
    )
endif()

set(MSAN_FLAGS "-fsanitize=memory -fno-omit-frame-pointer -fPIE")
set(CMAKE_REQUIRED_FLAGS ${MSAN_FLAGS})
check_cxx_compiler_flag(${MSAN_FLAGS} msan_works)
unset(CMAKE_REQUIRED_FLAGS)
if(msan_works)
  string(REPLACE " " ";" _msan_flags ${MSAN_FLAGS})
  add_executable(msan-example msan-example.cpp)
  target_compile_options(msan-example
    PUBLIC
      ${CXX_BASIC_FLAGS}
      ${_msan_flags}
    )
  target_link_libraries(msan-example
    PUBLIC
      ${_msan_flags}
      -pie
    )
endif()

set(UBSAN_FLAGS "-fsanitize=undefined -fno-omit-frame-pointer")
set(CMAKE_REQUIRED_FLAGS ${UBSAN_FLAGS})
check_cxx_compiler_flag(${UBSAN_FLAGS} ubsan_works)
unset(CMAKE_REQUIRED_FLAGS)
if(ubsan_works)
  string(REPLACE " " ";" _ubsan_flags ${UBSAN_FLAGS})
  add_executable(ubsan-example ubsan-example.cpp)
  target_compile_options(ubsan-example
    PUBLIC
      ${CXX_BASIC_FLAGS}
      ${_ubsan_flags}
    )
endif()
