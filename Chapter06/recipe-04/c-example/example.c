#include <stdio.h>

// provides PROJECT_VERSION, PROJECT_VERSION_MAJOR, PROJECT_VERSION_MINOR
#include "version.h"

int main() {
  printf("This is output from example code %s\n", PROJECT_VERSION);
  printf("The major version number is %i\n", PROJECT_VERSION_MAJOR);
  printf("The minor version number is %i\n", PROJECT_VERSION_MINOR);

  printf("Hello CMake world!\n");
}
