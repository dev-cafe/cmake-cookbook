#pragma once

#include <string>

class Animal {
public:
  Animal() = delete;
  explicit Animal(const std::string &n);
  std::string name() const;

protected:
  std::string name_;

private:
  virtual std::string name_impl() const = 0;
};
