add_library(message-objs OBJECT "")
target_sources(message-objs
  PUBLIC
    Message.hpp
  PRIVATE
    Message.cpp
  )
set_target_properties(message-objs PROPERTIES
  POSITION_INDEPENDENT_CODE 1
  )

add_library(message-shared SHARED $<TARGET_OBJECTS:message-objs>)
set_target_properties(message-shared PROPERTIES
  MACOSX_RPATH ON
  SOVERSION 1
  OUTPUT_NAME "message"
  )

add_library(message-static STATIC $<TARGET_OBJECTS:message-objs>)
set_target_properties(message-static PROPERTIES
  OUTPUT_NAME "message")

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

install(TARGETS hello-world message-shared message-static
  RUNTIME DESTINATION
    bin
  LIBRARY DESTINATION
    lib
  ARCHIVE DESTINATION
    lib
  )

install(FILES Message.hpp DESTINATION include/message)
