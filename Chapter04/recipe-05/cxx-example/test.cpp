#include <cassert>

#include "leaky_implementation.h"

int main() {
  int return_code = do_some_work();

  assert(return_code == 0);
}
