add_executable(fortran_test test.f90)
target_link_libraries(fortran_test evolution)

add_test(
  NAME
    test_evolution
  COMMAND
    ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/fortran_test
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  )
