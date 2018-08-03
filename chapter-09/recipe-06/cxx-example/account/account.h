/* CFFI would issue warning with pragma once */
#ifndef ACCOUNT_H_INCLUDED
#define ACCOUNT_H_INCLUDED

#ifndef ACCOUNT_API
#include "account_export.h"
#define ACCOUNT_API ACCOUNT_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

struct account_context;
typedef struct account_context account_context_t;

ACCOUNT_API
account_context_t *account_new();

ACCOUNT_API
void account_free(account_context_t *context);

ACCOUNT_API
void account_deposit(account_context_t *context, const double amount);

ACCOUNT_API
void account_withdraw(account_context_t *context, const double amount);

ACCOUNT_API
double account_get_balance(const account_context_t *context);

#ifdef __cplusplus
}
#endif

#endif /* ACCOUNT_H_INCLUDED */
