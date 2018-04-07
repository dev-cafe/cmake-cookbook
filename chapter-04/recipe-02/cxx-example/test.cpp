#include "sum_integers.hpp"

#include <vector>

#define CATCH_CONFIG_MAIN // This tells Catch to provide a main() - only do this in
                          // one cpp file
#include "catch.hpp"

TEST_CASE("Sum of integers is computed", "[sum]") {
  auto integers = {1, 2, 3, 4, 5};
  REQUIRE(sum_integers(integers) == 15);
}
