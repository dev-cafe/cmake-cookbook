add_library(
  account
  SHARED
  fortran_implementation.f90
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(
  account
  BASE_NAME account
  )

install(
  FILES
    ${PROJECT_BINARY_DIR}/account/implementation/account_export.h
  DESTINATION
    include
  )

install(
  TARGETS
    account
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )
