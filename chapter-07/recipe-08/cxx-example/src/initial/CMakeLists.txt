target_sources(automaton
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/initial.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/initial.hpp
  )

target_include_directories(automaton
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )
