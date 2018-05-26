set(DEPS_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/Deps)
message(STATUS "Installing dependencies to: ${DEPS_INSTALL_PREFIX}")

add_subdirectory(hdf5)
