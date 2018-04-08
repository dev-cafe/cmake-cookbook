#include "buggy.hpp"

int main() {
  int return_code = function_use_after_free();
  return return_code;
}
