#pragma once

#include "Animal.hpp"

class Cat final : public Animal {
public:
  Cat(const std::string &n) : Animal(n) {}

private:
  std::string name_impl() const override;
};
