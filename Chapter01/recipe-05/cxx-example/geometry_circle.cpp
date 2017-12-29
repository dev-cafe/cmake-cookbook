#include "geometry_circle.hpp"

#define _USE_MATH_DEFINES
#include <cmath>

namespace geometry {
namespace area {
double circle(double radius) { return M_PI * std::pow(radius, 2); }
} // namespace area
} // namespace geometry
