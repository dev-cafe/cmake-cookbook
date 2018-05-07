# implementation sources
add_subdirectory(implementation)

# install step is important for pip to work
install(
  FILES
    account.h
  DESTINATION
    include
  )
