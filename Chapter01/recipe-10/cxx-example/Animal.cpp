#include "Animal.hpp"

#include <string>

Animal::Animal(const std::string &n) : name_(n) {}

std::string Animal::name() const { return name_impl(); }
