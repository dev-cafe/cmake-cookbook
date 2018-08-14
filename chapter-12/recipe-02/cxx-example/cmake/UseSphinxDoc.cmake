find_package(PythonInterp REQUIRED)
find_package(Sphinx REQUIRED)

function(add_sphinx_doc)
  set(options)
  set(oneValueArgs
    SOURCE_DIR
    BUILD_DIR
    CACHE_DIR
    HTML_DIR
    CONF_FILE
    TARGET_NAME
    COMMENT
    )
  set(multiValueArgs)

  cmake_parse_arguments(SPHINX_DOC
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  configure_file(
    ${SPHINX_DOC_CONF_FILE}
    ${SPHINX_DOC_BUILD_DIR}/conf.py
    @ONLY
    )

  add_custom_target(${SPHINX_DOC_TARGET_NAME}
    COMMAND
      ${SPHINX_EXECUTABLE}
         -q
         -b html
         -c ${SPHINX_DOC_BUILD_DIR}
         -d ${SPHINX_DOC_CACHE_DIR}
         ${SPHINX_DOC_SOURCE_DIR}
         ${SPHINX_DOC_HTML_DIR}
    COMMENT
      "Building ${SPHINX_DOC_COMMENT} with Sphinx"
    VERBATIM
    )

  message(STATUS "Added ${SPHINX_DOC_TARGET_NAME} [Sphinx] target to build documentation")
endfunction()
