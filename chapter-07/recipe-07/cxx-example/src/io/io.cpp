#include "io.hpp"

#include <algorithm>
#include <iostream>
#include <vector>

void print_row(const std::vector<int> row) {
  std::for_each(row.begin(), row.end(), [](int const &value) {
    std::cout << (value == 1 ? '*' : ' ');
  });
  std::cout << std::endl;
}
