add_library(account
  SHARED
    implementation/fortran_implementation.f90
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(account
  BASE_NAME account
  )

file(
  GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/interface_file_names.cfg
  INPUT ${CMAKE_CURRENT_SOURCE_DIR}/interface_file_names.cfg.in
  )

set_target_properties(account
  PROPERTIES
    PUBLIC_HEADER "account.h;${CMAKE_CURRENT_BINARY_DIR}/account_export.h"
    RESOURCE "${CMAKE_CURRENT_BINARY_DIR}/interface_file_names.cfg"
  )

install(
  TARGETS
    account
  LIBRARY
    DESTINATION account/lib
  RUNTIME
    DESTINATION account/lib
  PUBLIC_HEADER
    DESTINATION account/include
  RESOURCE
    DESTINATION account
  )
