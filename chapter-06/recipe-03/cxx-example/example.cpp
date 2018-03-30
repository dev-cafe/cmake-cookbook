#include <iostream>
#include <vector>

#include "primes.h"

int main() {
  std::cout << "all prime numbers up to " << max_number << ":";

  for (auto prime : primes())
    std::cout << " " << prime;

  std::cout << std::endl;

  return 0;
}
