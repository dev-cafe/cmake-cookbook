#pragma once

#include "CRTP.hpp"

template <typename T> struct Incrementable : CRTP<T, Incrementable> {
  T &operator+=(T const &other) {
    this->underlying().get() += other.get();
    return this->underlying();
  }
};
