add_library(account
  SHARED
    fortran_implementation.f90
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(account
  BASE_NAME account
  )

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/account_export.h
  DESTINATION
    ${CMAKE_INSTALL_INCLUDEDIR}
  )

install(
  TARGETS
    account
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )
