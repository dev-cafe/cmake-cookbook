add_executable(example main.cpp)

add_subdirectory(conversion)
add_subdirectory(evolution)
add_subdirectory(initial)
add_subdirectory(io)
add_subdirectory(parser)

target_link_libraries(
  example
  conversion
  evolution
  initial
  io
  parser
  )
