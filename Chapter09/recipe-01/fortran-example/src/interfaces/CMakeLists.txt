include(FortranCInterface)
FortranCInterface_VERIFY()

find_package(PkgConfig REQUIRED QUIET)
pkg_search_module(UUID REQUIRED uuid IMPORTED_TARGET)
if(UUID_FOUND)
  message(STATUS "Found libuuid")
endif()
find_package(Backtrace REQUIRED)

add_library(bt-uuid-wrap SHARED interface_backtrace.f90 interface_uuid.f90)
target_include_directories(bt-uuid-wrap PUBLIC ${Backtrace_INCLUDE_DIRS})
target_link_libraries(bt-uuid-wrap
                      PUBLIC
                      PkgConfig::UUID
                      ${Backtrace_LIBRARIES})
