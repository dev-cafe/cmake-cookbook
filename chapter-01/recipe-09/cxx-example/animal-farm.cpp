#include "Animal.hpp"
#include "Cat.hpp"
#include "Dog.hpp"
#include "Factory.hpp"

#include <cstdlib>
#include <functional>
#include <iostream>
#include <memory>

typedef std::function<std::unique_ptr<Animal>(const std::string &)> CreateAnimal;

int main() {
  Factory<CreateAnimal> farm;
  farm.subscribe("CAT",
                 [](const std::string &n) { return std::make_unique<Cat>(n); });
  farm.subscribe("DOG",
                 [](const std::string &n) { return std::make_unique<Dog>(n); });

  std::unique_ptr<Animal> simon = farm.create("CAT", "Simon");
  std::unique_ptr<Animal> marlowe = farm.create("DOG", "Marlowe");

  std::cout << simon->name() << std::endl;
  std::cout << marlowe->name() << std::endl;

  return EXIT_SUCCESS;
}
