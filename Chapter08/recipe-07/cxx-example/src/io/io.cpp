#include "io.hpp"

#include <iostream>
#include <vector>

void print_row(const std::vector<int> row) {
  for (int i = 0; i < row.size(); i++) {
    if (row[i] == 1) {
      std::cout << "*";
    } else {
      std::cout << " ";
    }
  }
  std::cout << std::endl;
}
