#include <iostream>
#include <type_traits>
#include <utility>

// This code reproduced from
// https://github.com/SuperV1234/vittorioromeo.info/blob/master/extra/in_place_expr_validity/0_cpp11.cpp

struct Cat {
  void meow() const { std::cout << "meow\n"; }
};

struct Dog {
  void bark() const { std::cout << "bark\n"; }
};

// ---

template <typename...> using void_t = void;

template <typename, typename = void> struct has_meow : std::false_type {};

template <typename T>
struct has_meow<T, void_t<decltype(std::declval<T>().meow())>> : std::true_type {};

template <typename, typename = void> struct has_bark : std::false_type {};

template <typename T>
struct has_bark<T, void_t<decltype(std::declval<T>().bark())>> : std::true_type {};

// ---

template <typename T>
auto make_noise(const T & x) -> typename std::enable_if<has_meow<T>{}>::type {
  x.meow();
}

template <typename T>
auto make_noise(const T & x) -> typename std::enable_if<has_bark<T>{}>::type {
  x.bark();
}

int main() {
  make_noise(Cat{});
  make_noise(Dog{});
  // make_noise(int{});
}
