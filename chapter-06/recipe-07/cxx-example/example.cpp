#include <iostream>

// provides GIT_HASH
#include "version.h"

int main() {
  std::cout << "This code has been built from version " << GIT_HASH << std::endl;
}
