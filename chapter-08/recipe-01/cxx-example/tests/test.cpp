#include "sum_integers.hpp"

#include <vector>

// this tells catch to provide a main()
// only do this in one cpp file
#define CATCH_CONFIG_MAIN

#include "catch.hpp"

TEST_CASE("Sum of integers for a short vector", "[short]") {
  std::vector<int> integers = {1, 2, 3, 4, 5};
  REQUIRE(sum_integers(integers) == 15);
}

TEST_CASE("Sum of integers for a longer vector", "[long]") {
  std::vector<int> integers;
  for (int i = 1; i < 1001; ++i) {
    integers.push_back(i);
  }
  REQUIRE(sum_integers(integers) == 500500);
}
