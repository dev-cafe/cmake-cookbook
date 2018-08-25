target_sources(automaton
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/io.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/io.hpp
  )

target_include_directories(automaton
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )
