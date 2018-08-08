add_executable(test_short test_short.cpp)
target_link_libraries(test_short sum_integers)

add_executable(test_long test_long.cpp)
target_link_libraries(test_long sum_integers)

add_test(
  NAME
    test_short
  COMMAND
    $<TARGET_FILE:test_short>
  )

add_test(
  NAME
    test_long
  COMMAND
    $<TARGET_FILE:test_long>
  )
