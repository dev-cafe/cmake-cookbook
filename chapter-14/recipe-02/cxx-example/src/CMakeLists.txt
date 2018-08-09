# example library
add_library(sum_integers "")

target_sources(sum_integers
  PRIVATE
    sum_integers.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/sum_integers.hpp
  )

target_include_directories(sum_integers
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )

option(ENABLE_COVERAGE "Enable coverage" ON)

if(ENABLE_COVERAGE)
  if(CMAKE_CXX_COMPILER_ID MATCHES GNU)
    message(STATUS "Coverage analysis with gcov enabled") 
    target_compile_options(sum_integers
      PUBLIC
        -fprofile-arcs -ftest-coverage -g
      )
    target_link_libraries(sum_integers
      PUBLIC
        gcov
      )
  else()
    message(WARNING "Coverage not supported for this compiler")
  endif()
endif()

# main code
add_executable(sum_up main.cpp)

target_link_libraries(sum_up sum_integers)
