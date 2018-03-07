include(FortranCInterface)
FortranCInterface_VERIFY()

find_package(PkgConfig REQUIRED QUIET)
pkg_search_module(UUID REQUIRED uuid)
if(UUID_FOUND)
  message(STATUS "Found libuuid")
endif()
find_package(Backtrace REQUIRED)

add_library(bt-uuid-wrap SHARED interface_backtrace.f90 interface_uuid.f90)
target_include_directories(bt-uuid-wrap
  PUBLIC
    ${Backtrace_INCLUDE_DIRS}
  )
target_link_libraries(bt-uuid-wrap
  PUBLIC
    ${UUID_LIBRARIES}
    ${Backtrace_LIBRARIES}
  )
