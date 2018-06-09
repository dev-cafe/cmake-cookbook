#include <stdio.h>
#include <stdlib.h>

void init_randomgen(int seed) { srand((unsigned int)seed); }

int randomgen(int lower, int upper) {
  int low_num = 0;
  int hi_num = 0;

  if (lower < upper) {
    low_num = lower;
    hi_num = upper + 1; // include upper in output
  } else {
    low_num = upper + 1; // include upper in output
    hi_num = lower;
  }

  int result = (rand() % (hi_num - low_num)) + low_num;
  return result;
}
