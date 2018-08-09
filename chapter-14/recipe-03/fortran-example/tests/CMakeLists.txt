add_executable(leaky leaky.f90)
target_link_libraries(leaky buggy)

add_test(
  NAME
    leaky
  COMMAND
    $<TARGET_FILE:leaky>
  )
