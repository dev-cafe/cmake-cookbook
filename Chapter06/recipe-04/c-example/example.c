#include <stdio.h>

// provides VERSION_MAJOR, VERSION_MINOR, and VERSION_PATCH
#include "version.h"

int main() {
  printf("This is output from example code v%i.%i.%i:\n",
         VERSION_MAJOR,
         VERSION_MINOR,
         VERSION_PATCH);

  printf("Hello CMake world!\n");
}
