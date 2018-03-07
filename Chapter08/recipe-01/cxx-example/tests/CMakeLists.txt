add_executable(cpp_test test.cpp)
target_link_libraries(cpp_test sum_integers)

include(Testing)

add_Catch_test(
  NAME
    sum
  LABELS
    sum
    cpp_test
  COST
    1.5
  )
