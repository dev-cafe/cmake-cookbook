#pragma once

#define BOOST_PYTHON_STATIC_LIB
#include <boost/python.hpp>

class Account {
public:
  Account();
  ~Account();

  void deposit(const double amount);
  void withdraw(const double amount);
  double get_balance() const;

private:
  double balance;
};

namespace py = boost::python;

BOOST_PYTHON_MODULE(account) {
  py::class_<Account>("Account")
      .def("deposit", &Account::deposit)
      .def("withdraw", &Account::withdraw)
      .def("get_balance", &Account::get_balance);
}
