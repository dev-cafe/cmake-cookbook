#include "sum_integers.hpp"

#include <vector>

int sum_integers(const std::vector<int> integers) {
  int sum = 0;
  for (auto &i : integers) {
    sum += i;
  }
  return sum;
}
