include(FortranCInterface)
FortranCInterface_VERIFY()

find_package(Backtrace REQUIRED)

add_library(bt-randomgen-wrap SHARED "")

target_sources(bt-randomgen-wrap
  PRIVATE
    interface_backtrace.f90
    interface_randomgen.f90
    randomgen.c
  )

target_link_libraries(bt-randomgen-wrap
  PUBLIC
    ${Backtrace_LIBRARIES}
  )
