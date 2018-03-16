#include "parser.hpp"

#include <cassert>
#include <tuple>

std::tuple<int, int, int> parse_arguments(int argc, char *argv[]) {
  assert(argc == 4 && "program called with wrong number of arguments");

  int length = atoi(argv[1]);
  int num_steps = atoi(argv[2]);
  int rule_decimal = atoi(argv[3]);

  return std::make_tuple(length, num_steps, rule_decimal);
}
