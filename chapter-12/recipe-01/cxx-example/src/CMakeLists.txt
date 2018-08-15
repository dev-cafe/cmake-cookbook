add_library(message STATIC
  Message.hpp
  Message.cpp
  )

add_executable(hello-world hello-world.cpp)

target_link_libraries(hello-world
  PUBLIC
    message
  )
