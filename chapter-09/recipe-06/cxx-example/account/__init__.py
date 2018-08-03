from subprocess import check_output
from cffi import FFI
import os
import sys


def get_lib_handle(definitions, header_file, library_file):
    ffi = FFI()
    command = ['cc', '-E'] + definitions + [header_file]
    interface = check_output(command).decode('utf-8')

    # remove possible \r characters on windows which
    # would confuse cdef
    _interface = [l.strip('\r') for l in interface.split('\n')]

    ffi.cdef('\n'.join(_interface))
    lib = ffi.dlopen(library_file)
    return lib


_header_file = os.getenv('ACCOUNT_HEADER_FILE')
assert _header_file is not None

_library_file = os.getenv('ACCOUNT_LIBRARY_FILE')
assert _library_file is not None

_lib = get_lib_handle(definitions=['-DACCOUNT_API=', '-DACCOUNT_NOINCLUDE'],
                      header_file=_header_file,
                      library_file=_library_file)


# we change names to obtain a more pythonic API
new = _lib.account_new
free = _lib.account_free
deposit = _lib.account_deposit
withdraw = _lib.account_withdraw
get_balance = _lib.account_get_balance

__all__ = [
    '__version__',
    'new',
    'free',
    'deposit',
    'withdraw',
    'get_balance',
]
