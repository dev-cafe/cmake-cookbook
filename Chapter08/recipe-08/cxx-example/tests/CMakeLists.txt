add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test evolution)

add_test(
  NAME
    test_evolution
  COMMAND
    ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/cpp_test
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  )
