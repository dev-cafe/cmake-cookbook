foreach(_test IN ITEMS leaky use_after_free)
  add_executable(${_test} ${_test}.cpp)
  target_link_libraries(${_test} buggy)

  add_test(
    NAME
      ${_test}
    COMMAND
      $<TARGET_FILE:${_test}>
    )
endforeach()
