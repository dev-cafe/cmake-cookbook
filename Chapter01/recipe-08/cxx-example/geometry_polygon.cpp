#include "geometry_polygon.hpp"

#define _USE_MATH_DEFINES
#include <cmath>

namespace geometry {
namespace area {
double polygon(int nSides, double side) {
  double perimeter = nSides * side;
  double apothem = side / (2.0 * std::tan(M_PI / nSides));
  return (perimeter * apothem) / 2.0;
}
} // namespace area
} // namespace geometry
