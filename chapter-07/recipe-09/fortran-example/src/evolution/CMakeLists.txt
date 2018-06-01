add_library(evolution "")

target_sources(evolution
  PRIVATE
    empty.f90
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/ancestors.f90
    ${CMAKE_CURRENT_LIST_DIR}/evolution.f90
  )
