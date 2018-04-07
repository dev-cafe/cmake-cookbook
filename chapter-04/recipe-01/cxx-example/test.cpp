#include <vector>

#include "sum_integers.hpp"

int main() {
  std::vector<int> integers = {1, 2, 3, 4, 5};

  int sum = sum_integers(integers);

  if (sum == 15)
  {
    return 0;
  }
  else
  {
    return 1;
  }
}
