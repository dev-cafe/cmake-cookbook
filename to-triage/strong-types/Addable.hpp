#pragma once

#include "CRTP.hpp"

template <typename T> struct Addable : CRTP<T, Addable> {
  T operator+(T const & other) { return T(this->underlying().get() + other.get()); }
};
