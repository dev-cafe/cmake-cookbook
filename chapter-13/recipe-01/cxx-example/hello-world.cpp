#include <cstdlib>
#include <iostream>
#include <string>

const std::string cmake_system_name = SYSTEM_NAME;

int main() {
  std::cout << "Hello from " << cmake_system_name << std::endl;

  return EXIT_SUCCESS;
}
