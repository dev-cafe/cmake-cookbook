add_library(message OBJECT "")
target_sources(message
  PUBLIC
    Message.hpp
  PRIVATE
    Message.cpp
  )
set_target_properties(message PROPERTIES
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN 1
  )
file(INSTALL Message.hpp DESTINATION ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/message)

include(GenerateExportHeader)
generate_export_header(message
  BASE_NAME "message"
  EXPORT_MACRO_NAME "message_EXPORT"
  EXPORT_FILE_NAME "messageExport.h"
  DEPRECATED_MACRO_NAME "message_DEPRECATED"
  NO_EXPORT_MACRO_NAME "message_NO_EXPORT"
  STATIC_DEFINE "message_STATIC_DEFINE"
  NO_DEPRECATED_MACRO_NAME "message_NO_DEPRECATED"
  DEFINE_NO_DEPRECATED)
file(INSTALL ${CMAKE_CURRENT_BINARY_DIR}/messageExport.h DESTINATION ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/message)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/messageExport.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/message)
target_include_directories(message
  PRIVATE
    ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/message
  )

add_library(message-static STATIC $<TARGET_OBJECTS:message>)
set_target_properties(message-static PROPERTIES
  COMPILE_DEFINITIONS message_STATIC_DEFINE
  OUTPUT_NAME "message"
  )

add_library(message-shared SHARED $<TARGET_OBJECTS:message>)
set_target_properties(message-shared PROPERTIES
  VERSION 0
  SOVERSION 1
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN 1
  OUTPUT_NAME "message"
  )

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world
  PUBLIC
    message-shared
  )
target_include_directories(hello-world
  PRIVATE
    ${STAGED_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}/message
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

install(TARGETS hello-world message-static message-shared
  RUNTIME DESTINATION
    ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  )

install(FILES Message.hpp DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/message)
