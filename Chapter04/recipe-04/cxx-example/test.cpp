#include <vector>

#include "sum_integers.hpp"

#define BOOST_TEST_MODULE example_test_suite
#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(add_example) {
  std::vector<int> integers = {1, 2, 3, 4, 5};
  int result = sum_integers(integers);
  BOOST_REQUIRE(result == 15);
}
