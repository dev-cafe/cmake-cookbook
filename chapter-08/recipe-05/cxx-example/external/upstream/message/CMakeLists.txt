find_package(message 1 CONFIG QUIET)

if(message_FOUND)
  get_property(_loc TARGET message::message-shared PROPERTY LOCATION)
  message(STATUS "Found message: ${_loc} (found version ${message_VERSION})")
  add_library(message_external INTERFACE)  # dummy
else()
  message(STATUS "Suitable message could not be located, Building message instead.")

  include(ExternalProject)
  ExternalProject_Add(message_external
    GIT_REPOSITORY
      https://github.com/dev-cafe/message.git
    GIT_TAG
      master
    UPDATE_COMMAND
      ""
    CMAKE_ARGS
      -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
      -DCMAKE_CXX_EXTENSIONS=${CMAKE_CXX_EXTENSIONS}
      -DCMAKE_CXX_STANDARD_REQUIRED=${CMAKE_CXX_STANDARD_REQUIRED}
    CMAKE_CACHE_ARGS
      -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    TEST_AFTER_INSTALL
      1
    DOWNLOAD_NO_PROGRESS
      1
    LOG_CONFIGURE
      1
    LOG_BUILD
      1
    LOG_INSTALL
      1
    )

  if(WIN32 AND NOT CYGWIN)
    set(DEF_message_DIR ${STAGED_INSTALL_PREFIX}/CMake)
  else()
    set(DEF_message_DIR ${STAGED_INSTALL_PREFIX}/share/cmake/message)
  endif()

  file(TO_NATIVE_PATH "${DEF_message_DIR}" DEF_message_DIR)
  set(message_DIR ${DEF_message_DIR}
      CACHE PATH "Path to internally built messageConfig.cmake" FORCE)
endif()
