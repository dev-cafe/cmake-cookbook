add_subdirectory(interfaces)
add_subdirectory(utils)

add_executable(bt-uuid-example bt-uuid-example.f90)
target_include_directories(bt-uuid-example PRIVATE ${CMAKE_Fortran_MODULE_PATH})
target_link_libraries(bt-uuid-example PRIVATE bt-uuid-wrap utils)
