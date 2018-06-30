add_library(automaton "")
add_library(evolution "")

include(${CMAKE_CURRENT_LIST_DIR}/evolution/CMakeLists.txt)
include(${CMAKE_CURRENT_LIST_DIR}/initial/CMakeLists.txt)
include(${CMAKE_CURRENT_LIST_DIR}/io/CMakeLists.txt)
include(${CMAKE_CURRENT_LIST_DIR}/parser/CMakeLists.txt)

add_executable(automata "")

target_sources(automata
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/main.cpp
  )

target_link_libraries(automata
  PRIVATE
    automaton
    conversion
  )
