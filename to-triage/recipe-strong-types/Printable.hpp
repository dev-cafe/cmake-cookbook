#pragma once

#include "CRTP.hpp"

template <typename T> struct Printable : CRTP<T, Printable> {
  void print(std::ostream &os) const { os << this->underlying().get(); }
};
