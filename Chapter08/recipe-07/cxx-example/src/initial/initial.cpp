#include "initial.hpp"

#include <vector>

std::vector<int> initial_distribution(const int length) {

  // we start with a vector which is zeroed out
  std::vector<int> result(length, 0);

  // more or less in the middle we place a living cell
  result[length / 2] = 1;

  return result;
}
