function(add_catch_test)
  set(options)
  set(oneValueArgs NAME COST)
  set(multiValueArgs LABELS DEPENDS REFERENCE_FILES)
  cmake_parse_arguments(add_catch_test
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  message(STATUS "defining a test ...")
  message(STATUS "    NAME: ${add_catch_test_NAME}")
  message(STATUS "    LABELS: ${add_catch_test_LABELS}")
  message(STATUS "    COST: ${add_catch_test_COST}")
  message(STATUS "    REFERENCE_FILES: ${add_catch_test_REFERENCE_FILES}")

  add_test(
    NAME
      ${add_catch_test_NAME}
    COMMAND
      $<TARGET_FILE:cpp_test>
      [${add_catch_test_NAME}] --success --out
      ${PROJECT_BINARY_DIR}/tests/${add_catch_test_NAME}.log --durations yes
    WORKING_DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}
    )

  set_tests_properties(${add_catch_test_NAME}
    PROPERTIES
      LABELS "${add_catch_test_LABELS}"
    )

  if(add_catch_test_COST)
    set_tests_properties(${add_catch_test_NAME}
      PROPERTIES
        COST ${add_catch_test_COST}
      )
  endif()

  if(add_catch_test_DEPENDS)
    set_tests_properties(${add_catch_test_NAME}
      PROPERTIES
        DEPENDS ${add_catch_test_DEPENDS}
      )
  endif()

  if(add_catch_test_REFERENCE_FILES)
    file(
      COPY
        ${add_catch_test_REFERENCE_FILES}
      DESTINATION
        ${CMAKE_CURRENT_BINARY_DIR}
      )
  endif()
endfunction()
