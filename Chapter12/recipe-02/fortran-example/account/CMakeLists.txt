# specify where to place libraries
include(GNUInstallDirs)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})

# implementation sources
add_subdirectory(implementation)

# install step is important for pip to work
install(
  FILES
    account.h
  DESTINATION
    include
  )
