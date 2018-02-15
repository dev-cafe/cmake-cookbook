find_package(PythonInterp REQUIRED)
find_package(Sphinx REQUIRED)
set(SPHINX_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/_build")
set(SPHINX_CACHE_DIR "${CMAKE_CURRENT_BINARY_DIR}/_doctrees")
set(SPHINX_HTML_DIR "${CMAKE_CURRENT_BINARY_DIR}/html")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/docs/conf.py.in
               ${SPHINX_BUILD_DIR}/conf.py
               @ONLY)
add_custom_target(docs
  COMMAND
    ${SPHINX_EXECUTABLE}
       -q -b html
       -c ${SPHINX_BUILD_DIR}
       -d ${SPHINX_CACHE_DIR}
       ${CMAKE_CURRENT_SOURCE_DIR}/docs
       ${SPHINX_HTML_DIR}
  COMMENT "Building HTML documentation with Sphinx")
message(STATUS "Added docs target to build documentation")
