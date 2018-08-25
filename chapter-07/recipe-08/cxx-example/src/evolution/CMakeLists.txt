target_sources(automaton
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/evolution.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/evolution.hpp
  )

target_include_directories(automaton
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )

target_sources(evolution
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/evolution.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/evolution.hpp
  )

target_include_directories(evolution
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
  )
