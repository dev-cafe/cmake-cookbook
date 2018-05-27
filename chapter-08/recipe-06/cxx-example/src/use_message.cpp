#include <cstdlib>
#include <iostream>

#ifdef USING_message
#include <message/Message.hpp>
void messaging() {
  Message say_hello("Hello, World! From a client of yours!");
  std::cout << say_hello << std::endl;

  Message say_goodbye("Goodbye, World! From a client of yours!");
  std::cout << say_goodbye << std::endl;
}
#else
void messaging() {
  std::cout << "Hello, World! From a client of yours!" << std::endl;

  std::cout << "Goodbye, World! From a client of yours!" << std::endl;
}
#endif

int main() {
  messaging();
  return EXIT_SUCCESS;
}
