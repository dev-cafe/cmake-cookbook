add_subdirectory(linalg_wrap)

add_executable(linear-algebra linear-algebra.cpp)
target_link_libraries(linear-algebra PRIVATE linalg_wrap)
