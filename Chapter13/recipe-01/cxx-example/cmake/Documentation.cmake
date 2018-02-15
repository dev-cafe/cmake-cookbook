find_package(Perl REQUIRED)
find_package(Doxygen REQUIRED)

set(DOXYGEN_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/_build")
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in
  ${DOXYGEN_BUILD_DIR}/Doxyfile
  @ONLY
  )
add_custom_target(docs
  COMMAND
    ${DOXYGEN_EXECUTABLE} Doxyfile
  WORKING_DIRECTORY
    ${DOXYGEN_BUILD_DIR}
  COMMENT
    "Building HTML documentation with Doxygen"
  VERBATIM
  )
message(STATUS "Added docs target to build documentation")
