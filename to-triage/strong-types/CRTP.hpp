#pragma once

template <typename T, template <typename> class Policy> struct CRTP {
  T & underlying() { return static_cast<T &>(*this); }
  T const & underlying() const { return static_cast<T const &>(*this); }
};
