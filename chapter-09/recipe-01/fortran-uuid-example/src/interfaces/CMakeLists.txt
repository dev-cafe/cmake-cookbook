include(FortranCInterface)
FortranCInterface_VERIFY()

find_package(PkgConfig REQUIRED QUIET)
pkg_search_module(UUID REQUIRED uuid IMPORTED_TARGET)
if(TARGET PkgConfig::UUID)
  message(STATUS "Found libuuid")
endif()
find_package(Backtrace REQUIRED)

add_library(bt-uuid-wrap SHARED "")
target_sources(bt-uuid-wrap
  PRIVATE
    interface_backtrace.f90
    interface_uuid.f90
  )
target_link_libraries(bt-uuid-wrap
  PUBLIC
    PkgConfig::UUID
    ${Backtrace_LIBRARIES}
  )
