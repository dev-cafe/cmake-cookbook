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

# main code
add_executable(sum_up main.cpp)

target_link_libraries(sum_up sum_integers)
