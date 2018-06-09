#include <random>

extern "C"
int randomgen(int lower, int upper) {
  std::random_device rd;
  std::mt19937 mt(rd());
  std::uniform_real_distribution<double> dist(lower, upper);
  return dist(mt);
}
