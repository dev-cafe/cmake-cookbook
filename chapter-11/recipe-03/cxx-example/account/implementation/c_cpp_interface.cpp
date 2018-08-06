#include "account.h"
#include "cpp_implementation.hpp"

#define AS_TYPE(Type, Obj) reinterpret_cast<Type *>(Obj)
#define AS_CTYPE(Type, Obj) reinterpret_cast<const Type *>(Obj)

account_context_t *account_new() {
  return AS_TYPE(account_context_t, new Account());
}

void account_free(account_context_t *context) { delete AS_TYPE(Account, context); }

void account_deposit(account_context_t *context, const double amount) {
  return AS_TYPE(Account, context)->deposit(amount);
}

void account_withdraw(account_context_t *context, const double amount) {
  return AS_TYPE(Account, context)->withdraw(amount);
}

double account_get_balance(const account_context_t *context) {
  return AS_CTYPE(Account, context)->get_balance();
}
