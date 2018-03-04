set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
set(CMAKECONFIG_INSTALL_DIR ${CMAKE_INSTALL_DATADIR}/cmake/message)

add_library(message-objs OBJECT Message.cpp)
target_sources(message-objs
  PUBLIC
    Message.hpp
  )
set_target_properties(message-objs PROPERTIES
  POSITION_INDEPENDENT_CODE 1
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN 1
  )
target_compile_definitions(message-objs
  PUBLIC
    message_objs_EXPORTS
  )
# Remove dependency on UUID if on Windows
if(WIN32)
  target_compile_definitions(message-objs
    PUBLIC
      EXCLUDE_UUID
    )
else()
  find_package(PkgConfig REQUIRED QUIET)
  pkg_search_module(UUID REQUIRED uuid IMPORTED_TARGET)
  if(UUID_FOUND)
    message(STATUS "Found libuuid")
  endif()
endif()

include(GenerateExportHeader)
generate_export_header(message-objs
  BASE_NAME "message"
  EXPORT_MACRO_NAME "message_EXPORT"
  EXPORT_FILE_NAME "messageExport.h"
  DEPRECATED_MACRO_NAME "message_DEPRECATED"
  NO_EXPORT_MACRO_NAME "message_NO_EXPORT"
  STATIC_DEFINE "message_STATIC_DEFINE"
  NO_DEPRECATED_MACRO_NAME "message_NO_DEPRECATED"
  DEFINE_NO_DEPRECATED
  )
install(
  FILES
    Message.hpp
    ${CMAKE_CURRENT_BINARY_DIR}/messageExport.h
  DESTINATION
    ${CMAKE_INSTALL_INCLUDEDIR}/message
  )

add_library(message-static STATIC $<TARGET_OBJECTS:message-objs>)
target_link_libraries(message-static
  PUBLIC
    $<$<NOT:$<BOOL:${WIN32}>>:PkgConfig::UUID>
  )
target_compile_definitions(message-static
  INTERFACE
    $<INSTALL_INTERFACE:USING_message>
  PRIVATE
    message_STATIC_DEFINE
  )
target_include_directories(message-static
  INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  )
set_target_properties(message-static PROPERTIES
  OUTPUT_NAME "message"
  )
install(
  TARGETS
    message-static
  EXPORT
    "messageTargets-static"
  ARCHIVE DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION
    ${CMAKE_INSTALL_INCLUDEDIR}
  )
install(
  EXPORT
    "messageTargets-static"
  NAMESPACE
    "message::"
  DESTINATION
    ${CMAKECONFIG_INSTALL_DIR}
  )

add_library(message-shared SHARED $<TARGET_OBJECTS:message-objs>)
target_link_libraries(message-shared
  PUBLIC
    $<$<NOT:$<BOOL:${WIN32}>>:PkgConfig::UUID>
  )
target_compile_definitions(message-shared
  INTERFACE
    $<INSTALL_INTERFACE:USING_message>
  )
target_include_directories(message-shared
  INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  )
set_target_properties(message-shared PROPERTIES
  MACOSX_RPATH ON
  SOVERSION 1
  OUTPUT_NAME "message"
  )
install(
  TARGETS
    message-shared
  EXPORT
    "messageTargets-shared"
  RUNTIME DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION
    ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION
    ${CMAKE_INSTALL_INCLUDEDIR}
  )
install(
  EXPORT
    "messageTargets-shared"
  NAMESPACE
    "message::"
  DESTINATION
    ${CMAKECONFIG_INSTALL_DIR}
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
    INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
    INSTALL_RPATH_USE_LINK_PATH ON
  )
install(
  TARGETS
    hello-world
  EXPORT
    "messageTargets-hello-world"
  RUNTIME DESTINATION
    ${CMAKE_INSTALL_BINDIR}
  )
install(
  EXPORT
    "messageTargets-hello-world"
  NAMESPACE
    "message::"
  DESTINATION
    ${CMAKECONFIG_INSTALL_DIR}
  )

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/messageConfigVersion.cmake
  VERSION 1.0.0
  COMPATIBILITY SameMajorVersion
  )

configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/messageConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/messageConfig.cmake
  INSTALL_DESTINATION ${CMAKECONFIG_INSTALL_DIR}
  )

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/messageConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/messageConfigVersion.cmake
  DESTINATION
    ${CMAKECONFIG_INSTALL_DIR}
  )

set(CPACK_PACKAGE_NAME "message")
set(CPACK_PACKAGE_VENDOR "CMakeRecipes")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${PROJECT_SOURCE_DIR}/INSTALL.md")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "message: a small messaging library")
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git/;.gitignore;/external/")

set(CPACK_GENERATOR "RPM")
set(CPACK_RPM_PACKAGE_RELEASE "1")
set(CPACK_RPM_PACKAGE_LICENSE "MIT")
set(CPACK_RPM_PACKAGE_REQUIRES "uuid-devel")

include(CPack)
