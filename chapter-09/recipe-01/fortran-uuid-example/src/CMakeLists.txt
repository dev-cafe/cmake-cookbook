add_subdirectory(interfaces)
add_subdirectory(utils)

add_executable(bt-uuid-example bt-uuid-example.f90)
target_link_libraries(bt-uuid-example
  PRIVATE
    bt-uuid-wrap
    utils
  )
