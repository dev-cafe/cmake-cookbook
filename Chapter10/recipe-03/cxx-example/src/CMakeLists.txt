add_library(message-objs OBJECT "")
target_sources(message-objs PUBLIC Message.hpp PRIVATE Message.cpp)
set_target_properties(message-objs
                      PROPERTIES POSITION_INDEPENDENT_CODE
                                 1
                                 CXX_VISIBILITY_PRESET
                                 hidden
                                 VISIBILITY_INLINES_HIDDEN
                                 1)

include(GenerateExportHeader)
generate_export_header(message-objs
                       BASE_NAME
                       "message"
                       EXPORT_MACRO_NAME
                       "message_EXPORT"
                       EXPORT_FILE_NAME
                       "messageExport.h"
                       DEPRECATED_MACRO_NAME
                       "message_DEPRECATED"
                       NO_EXPORT_MACRO_NAME
                       "message_NO_EXPORT"
                       STATIC_DEFINE
                       "message_STATIC_DEFINE"
                       NO_DEPRECATED_MACRO_NAME
                       "message_NO_DEPRECATED"
                       DEFINE_NO_DEPRECATED)
target_include_directories(message-objs PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

add_library(message-static STATIC $<TARGET_OBJECTS:message-objs>)
set_target_properties(message-static
                      PROPERTIES COMPILE_DEFINITIONS
                                 message_STATIC_DEFINE
                                 OUTPUT_NAME
                                 "message")

add_library(message-shared SHARED $<TARGET_OBJECTS:message-objs>)
set_target_properties(
  message-shared PROPERTIES MACOSX_RPATH ON SOVERSION 1 OUTPUT_NAME "message")

add_executable(hello-world hello-world.cpp)
target_link_libraries(hello-world PUBLIC message-shared)
target_include_directories(hello-world PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

set_target_properties(hello-world
                      PROPERTIES
                        MACOSX_RPATH
                        ON
                        SKIP_BUILD_RPATH
                        OFF
                        BUILD_WITH_INSTALL_RPATH
                        OFF
                        INSTALL_RPATH
                        "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
                        INSTALL_RPATH_USE_LINK_PATH
                        ON)

install(TARGETS hello-world message-static message-shared
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/messageExport.h
              Message.hpp
              DESTINATION
              ${CMAKE_INSTALL_INCLUDEDIR}/message)
