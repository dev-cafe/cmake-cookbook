find_package(Doxygen REQUIRED)
find_package(Perl REQUIRED)
find_package(PythonInterp REQUIRED)
find_package(Sphinx REQUIRED)
include(FindPythonModule)
find_python_module(breathe REQUIRED)

set(SPHINX_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/_build")
set(SPHINX_CACHE_DIR "${CMAKE_CURRENT_BINARY_DIR}/_doctrees")
set(SPHINX_HTML_DIR "${CMAKE_CURRENT_BINARY_DIR}/html")
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/docs/conf.py.in
  ${SPHINX_BUILD_DIR}/conf.py
  @ONLY
  )
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in
  ${SPHINX_BUILD_DIR}/Doxyfile
  @ONLY
  )
add_custom_target(docs
  COMMAND
    ${SPHINX_EXECUTABLE}
       -q -b html
       -c ${SPHINX_BUILD_DIR}
       -d ${SPHINX_CACHE_DIR}
       ${CMAKE_CURRENT_SOURCE_DIR}/docs
       ${SPHINX_HTML_DIR}
  COMMENT
    "Building HTML documentation with Doxygen and Sphinx"
  VERBATIM
  )
message(STATUS "Added docs target to build documentation")
