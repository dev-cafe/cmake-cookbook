add_executable(fortran_test test.f90)
target_link_libraries(fortran_test evolution)

add_test(
  NAME
    test_evolution
  COMMAND
    $<TARGET_FILE:fortran_test>
  )
