find_package(message 1 CONFIG QUIET)
if(message_FOUND)
  get_property(_loc TARGET message::message-shared PROPERTY LOCATION)
  message(STATUS "Found message: ${_loc} (found version ${message_VERSION})")
  add_library(message_external INTERFACE)  # dummy
else()
  include(ExternalProject)
  message(STATUS "Suitable message could not be located, Building message instead.")
  ExternalProject_Add(message_external
    GIT_REPOSITORY
      https://github.com/dev-cafe/message.git
    GIT_TAG
      master
    UPDATE_COMMAND
      ""
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_PREFIX}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    CMAKE_CACHE_ARGS
      -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    )
  set(message_DIR ${DEPS_INSTALL_PREFIX}/share/cmake/message
    CACHE PATH "Path to internally built messageConfig.cmake" FORCE)
endif()
