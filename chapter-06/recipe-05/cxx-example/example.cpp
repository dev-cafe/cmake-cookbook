// provides PROGRAM_VERSION
#include "version.hpp"

#include <iostream>

int main() {
  std::cout << "This is output from code v" << PROGRAM_VERSION << std::endl;

  std::cout << "Hello CMake world!" << std::endl;
}
