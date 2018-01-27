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
file(INSTALL Message.hpp
     DESTINATION
       ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/message
    )

add_library(message-shared SHARED $<TARGET_OBJECTS:message-objs>)
set_target_properties(message-shared PROPERTIES
  VERSION 0
  SOVERSION 1
  OUTPUT_NAME "message")

add_library(message-static STATIC $<TARGET_OBJECTS:message-objs>)
set_target_properties(message-static PROPERTIES
  OUTPUT_NAME "message")

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world
  PUBLIC
    message-shared
  )

# <<<  RPATH  >>>

list(APPEND project_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}" "${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
message(STATUS "Project RPATH is ${project_RPATH}")

set_target_properties(hello-world
  PROPERTIES
    MACOSX_RPATH ON
    INSTALL_RPATH "${project_RPATH}"
    INSTALL_RPATH_USE_LINK_PATH ON
    BUILD_WITH_INSTALL_RPATH ON
  )

install(TARGETS hello-world message-shared message-static
  RUNTIME DESTINATION
    ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  )

install(FILES Message.hpp DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/message)
