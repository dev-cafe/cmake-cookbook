#include "cpp_implementation.hpp"

#include <cassert>

Account::Account() {
  balance = 0.0;
  is_initialized = true;
}

Account::~Account() {
  assert(is_initialized);
  is_initialized = false;
}

void Account::deposit(const double amount) {
  assert(is_initialized);
  balance += amount;
}

void Account::withdraw(const double amount) {
  assert(is_initialized);
  balance -= amount;
}

double Account::get_balance() const {
  assert(is_initialized);
  return balance;
}
