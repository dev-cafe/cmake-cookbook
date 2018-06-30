add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test evolution)

add_test(
  NAME
    test_evolution
  COMMAND
    $<TARGET_FILE:cpp_test>
  )
