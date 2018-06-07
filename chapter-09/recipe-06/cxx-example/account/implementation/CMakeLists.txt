add_library(account
  SHARED
    c_cpp_interface.cpp
    cpp_implementation.cpp
  )

target_include_directories(account
  PRIVATE
    ${PROJECT_SOURCE_DIR}/account
    ${PROJECT_BINARY_DIR}/account/implementation
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(account
  BASE_NAME account
  )
