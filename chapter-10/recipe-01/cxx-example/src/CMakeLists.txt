# <<< Build targets >>>

add_library(message-objs OBJECT "")

target_sources(message-objs
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Message.cpp
  )

set_target_properties(message-objs
  PROPERTIES
    POSITION_INDEPENDENT_CODE 1
  )

add_library(message-shared SHARED $<TARGET_OBJECTS:message-objs>)

set_target_properties(message-shared
  PROPERTIES
    MACOSX_RPATH ON
    SOVERSION ${PROJECT_VERSION_MAJOR}
    OUTPUT_NAME "message"
    PUBLIC_HEADER "Message.hpp"
  )

add_library(message-static STATIC $<TARGET_OBJECTS:message-objs>)

set_target_properties(message-static
  PROPERTIES
    OUTPUT_NAME "message_s"
    PUBLIC_HEADER "Message.hpp"
  )

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world
  PUBLIC
    message-shared
  )

set_target_properties(hello-world
  PROPERTIES
    MACOSX_RPATH ON
    SKIP_BUILD_RPATH OFF
    BUILD_WITH_INSTALL_RPATH OFF
    INSTALL_RPATH "$ORIGIN/../lib"
    INSTALL_RPATH_USE_LINK_PATH ON
  )

# <<< Install targets >>>

install(
  TARGETS
    hello-world
    message-shared
    message-static
  RUNTIME
    DESTINATION bin
    COMPONENT bin
  LIBRARY
    DESTINATION lib
    COMPONENT lib
  ARCHIVE
    DESTINATION lib
    COMPONENT lib
  PUBLIC_HEADER
    DESTINATION include/message
    COMPONENT dev
  )

add_executable(hello-world-static hello-world.cpp)

target_link_libraries(hello-world-static
  PUBLIC
    message-static
  )
