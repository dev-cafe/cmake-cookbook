add_library(account
  SHARED
    implementation/fortran_implementation.f90
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(account
  BASE_NAME account
  )
