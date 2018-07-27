add_test(
  NAME test_shared
  COMMAND $<TARGET_FILE:hello-world_wDSO>
  )

add_test(
  NAME test_static
  COMMAND $<TARGET_FILE:hello-world_wAR>
  )
