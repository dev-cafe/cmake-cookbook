from .cffi_helpers import get_lib_handle
import os
import sys


def get_env(v):
    _v = os.getenv(v)
    if _v is None:
        sys.stderr.write('ERROR: variable {0} is undefined\n'.format(v))
        sys.exit(1)
    return _v


_this_path = os.path.dirname(os.path.realpath(__file__))

_library_dir = os.getenv('ACCOUNT_LIBRARY_DIR')
if _library_dir is None:
    _library_dir = os.path.join(_this_path, 'lib')

_include_dir = os.getenv('ACCOUNT_INCLUDE_DIR')
if _include_dir is None:
    _include_dir = os.path.join(_this_path, 'include')

_lib = get_lib_handle(['-DACCOUNT_API=', '-DACCOUNT_NOINCLUDE'],
                      'account.h',
                      'account',
                      _library_dir,
                      _include_dir)

# we change names to get a more pythonic API
new = _lib.account_new
free = _lib.account_free
deposit = _lib.account_deposit
withdraw = _lib.account_withdraw
get_balance = _lib.account_get_balance
