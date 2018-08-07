include(FetchContent)

FetchContent_Declare(
  pybind11_sources
  GIT_REPOSITORY https://github.com/pybind/pybind11.git
  GIT_TAG        v2.2
)

FetchContent_GetProperties(pybind11_sources)

if(NOT pybind11_sources_POPULATED)
  FetchContent_Populate(pybind11_sources)

  add_subdirectory(
    ${pybind11_sources_SOURCE_DIR}
    ${pybind11_sources_BINARY_DIR}
    )
endif()

# create python module
add_library(account
  MODULE
    account.cpp
  )

# workaround for problem with different names of some math
# functions on Windows MSYS
# this probably only concerns our CI setup on Appveyor
# and may not be needed generally
if(WIN32 AND (NOT MSVC))
  target_compile_definitions(account
    PUBLIC
      "_hypot=hypot"
    )
endif()

target_link_libraries(account
  PUBLIC
    pybind11::module
  )

set_target_properties(account
  PROPERTIES
    PREFIX "${PYTHON_MODULE_PREFIX}"
    SUFFIX "${PYTHON_MODULE_EXTENSION}"
  )

install(
  TARGETS
    account
  LIBRARY
    DESTINATION account
  )
