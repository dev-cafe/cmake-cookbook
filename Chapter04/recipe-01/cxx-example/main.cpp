#include <iostream>
#include <vector>

#include "sum_integers.h"

// we assume all arguments are integers and we sum them up
// for simplicity we do not verify the type of arguments
int main(int argc, char *argv[]) {

  std::vector<int> integers;
  for (int i = 1; i < argc; i++) {
    integers.push_back(atoi(argv[i]));
  }
  int sum = sum_integers(integers);

  std::cout << sum << std::endl;
}
