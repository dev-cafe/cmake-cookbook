#pragma once

#include "CRTP.hpp"

template <typename T> struct Multiplicable : CRTP<T, Multiplicable> {
  T operator*(T const &other) { return T(this->underlying().get() * other.get()); }
};
