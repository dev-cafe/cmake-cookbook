add_library(account
  SHARED
    implementation/c_cpp_interface.cpp
    implementation/cpp_implementation.cpp
  )

target_include_directories(account
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  )

# generate account_export.h
include(GenerateExportHeader)
generate_export_header(account
  BASE_NAME account
  )
