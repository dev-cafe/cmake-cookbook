#include <cstdio>

int main(int argc, char **argv) {
  int *a = new int[10];
  a[5] = 0;
  volatile int b = a[argc];
  if (b)
    printf("xx\n");
  return 0;
}
