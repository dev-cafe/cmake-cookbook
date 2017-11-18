#include <cassert>
#include <vector>

#include "sum_integers.h"

int main() {
  std::vector<int> integers = {1, 2, 3, 4, 5};

  int sum = sum_integers(integers);

  assert(sum == 15);
}
