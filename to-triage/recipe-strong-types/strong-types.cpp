#include <cmath>
#include <cstdlib>
#include <iostream>

#include "Addable.hpp"
#include "Incrementable.hpp"
#include "Multiplicable.hpp"
#include "NamedType.hpp"
#include "Printable.hpp"

using Length = NamedType<double,
                         struct LengthParameter,
                         Addable,
                         Incrementable,
                         Multiplicable,
                         Printable>;

int main() {

  Length l1(M_PI);
  std::cout << "l1 = " << l1 << std::endl;
  Length l2(5);
  std::cout << "l2 = " << l2 << std::endl;

  std::cout << "l1 + l2 = " << l1 + l2 << std::endl;
  std::cout << "l1 * l2 = " << l1 * l2 << std::endl;

  return EXIT_SUCCESS;
}
