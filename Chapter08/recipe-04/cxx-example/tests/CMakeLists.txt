add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test sum_integers)

include(testing)

add_catch_test(
  NAME
    short
  LABELS
    short
    cpp_test
  COST
    1.5
  )

add_catch_test(
  NAME
    long
  LABELS
    long
    cpp_test
  COST
    2.5
  )
