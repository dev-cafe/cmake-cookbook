add_library(buggy "")

target_sources(buggy
  PRIVATE
    buggy.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/buggy.hpp
  )

target_include_directories(buggy
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )

option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

if(ENABLE_ASAN)
  if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    message(STATUS "AddressSanitizer enabled")
    target_compile_options(buggy
      PUBLIC
        -g -O1 -fsanitize=address -fno-omit-frame-pointer
      )
    target_link_libraries(buggy
      PUBLIC
        asan
      )
  else()
    message(WARNING "AddressSanitizer not supported for this compiler")
  endif()
endif()
