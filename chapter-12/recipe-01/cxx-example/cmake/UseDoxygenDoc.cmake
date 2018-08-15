find_package(Perl REQUIRED)
find_package(Doxygen REQUIRED)

function(add_doxygen_doc)
  set(options)
  set(oneValueArgs BUILD_DIR DOXY_FILE TARGET_NAME COMMENT)
  set(multiValueArgs)

  cmake_parse_arguments(DOXY_DOC
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  configure_file(
    ${DOXY_DOC_DOXY_FILE}
    ${DOXY_DOC_BUILD_DIR}/Doxyfile
    @ONLY
    )

  add_custom_target(${DOXY_DOC_TARGET_NAME}
    COMMAND
      ${DOXYGEN_EXECUTABLE} Doxyfile
    WORKING_DIRECTORY
      ${DOXY_DOC_BUILD_DIR}
    COMMENT
      "Building ${DOXY_DOC_COMMENT} with Doxygen"
    VERBATIM
    )

  message(STATUS "Added ${DOXY_DOC_TARGET_NAME} [Doxygen] target to build documentation")
endfunction()
