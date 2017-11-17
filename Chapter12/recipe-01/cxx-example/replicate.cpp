#include <cassert>
#include <iostream>
#include <string>

int main(int argc, char * argv[]) {

  assert(argc == 3);

  // convert first argument to an integer
  // for simplicity we do not check its type
  int num_to_repeat = atoi(argv[1]);

  std::string text = argv[2];

  for (int i = 0; i < num_to_repeat; i++) {
    if (i > 0)
      std::cout << " ";
    std::cout << text;
  }

  std::cout << std::endl;
}
