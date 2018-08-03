import os
import sys
sys.path.append(os.getenv('ACCOUNT_MODULE_PATH'))

from account import Account  # isort: skip

account1 = Account()

account1.deposit(100.0)
account1.deposit(100.0)

account2 = Account()

account2.deposit(200.0)
account2.deposit(200.0)

account1.withdraw(50.0)

assert account1.get_balance() == 150.0
assert account2.get_balance() == 400.0
