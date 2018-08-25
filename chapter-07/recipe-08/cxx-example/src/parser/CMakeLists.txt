target_sources(automaton
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/parser.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/parser.hpp
  )

target_include_directories(automaton
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )
