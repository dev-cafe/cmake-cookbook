set(DEPS_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/Deps)
message(STATUS "${PROJECT_NAME} staged install: ${DEPS_INSTALL_PREFIX}")

add_subdirectory(message)
