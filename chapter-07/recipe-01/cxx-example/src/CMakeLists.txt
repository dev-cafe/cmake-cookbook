set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

add_library(sum_integers sum_integers.cpp)

add_executable(sum_up main.cpp)

target_link_libraries(sum_up sum_integers)
