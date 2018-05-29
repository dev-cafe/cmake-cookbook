// provides GIT_HASH
#include "version.hpp"

#include <iostream>

int main() {
  std::cout << "This code has been built from version " << GIT_HASH << std::endl;
}
