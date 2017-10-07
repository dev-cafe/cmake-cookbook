#include <cstdlib>
#include <iostream>
#include <string>

std::string say_hello() {
#ifdef IS_32_BIT_ARCH
  return std::string("this code is compiled on a 32 bit host processor");
#elif IS_64_BIT_ARCH
  return std::string("this code is compiled on a 64 bit host processor");
#else
  return std::string("this code is compiled on a host processor with unknown architecture");
#endif
}

int main() {
  std::cout << say_hello() << std::endl;
  return EXIT_SUCCESS;
}
