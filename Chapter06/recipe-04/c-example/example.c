#include <stdio.h>

// provides PROJECT_VERSION
#include "version.h"

int main() {
  printf("This is output from example code v%s:\n", PROJECT_VERSION);

  printf("Hello CMake world!\n");
}
