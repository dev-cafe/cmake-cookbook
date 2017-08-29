#include "geometry_circle.hpp"

#include <cmath>

namespace geometry {
namespace area {
double circle(double radius) { return M_PI * std::pow(radius, 2); }
}
}
