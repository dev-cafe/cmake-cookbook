import os
import sys
from configparser import ConfigParser
from pathlib import Path
from subprocess import check_output

from cffi import FFI


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


# this interface requires the header file and library file
# and these can be either provided by interface_file_names.cfg
# in the same path as this file
# or if this is not found then using environment variables
_this_path = Path(os.path.dirname(os.path.realpath(__file__)))
_cfg_file = _this_path / 'interface_file_names.cfg'
if _cfg_file.exists():
    config = ConfigParser()
    config.read(str(_cfg_file))
    header_file_name = config.get('configuration', 'header_file_name')
    _header_file = _this_path / 'include' / header_file_name
    _header_file = str(_header_file)
    library_file_name = config.get('configuration', 'library_file_name')
    _library_file = _this_path / 'lib' / library_file_name
    _library_file = str(_library_file)
else:
    _header_file = os.getenv('ACCOUNT_HEADER_FILE')
    assert _header_file is not None
    _library_file = os.getenv('ACCOUNT_LIBRARY_FILE')
    assert _library_file is not None

_lib = get_lib_handle(
    definitions=['-DACCOUNT_API=', '-DACCOUNT_NOINCLUDE'],
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
