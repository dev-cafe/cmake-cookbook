#include "buggy.hpp"

#include <iostream>

int function_leaky() {

  double *my_array = new double[1000];

  // do some work ...

  // we forget to deallocate the array
  // delete[] my_array;

  return 0;
}

int function_use_after_free() {

  double *another_array = new double[1000];

  // do some work ...

  // deallocate it, good!
  delete[] another_array;

  // however, we accidentally use the array
  // after it has been deallocated
  std::cout << "not sure what we get: " << another_array[123] << std::endl;

  return 0;
}
