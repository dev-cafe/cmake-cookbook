import sys
import os
from subprocess import Popen, PIPE
from cffi import FFI


def _get_library_suffix():
    if sys.platform == "darwin":
        return 'dylib'
    else:
        return 'so'


def get_lib_handle(definitions, header, library, library_dir, include_dir):
    ffi = FFI()
    command = ['cc', '-E'] + definitions + [os.path.join(include_dir, header)]
    interface = Popen(command, stdout=PIPE).communicate()[0].decode("utf-8")
    ffi.cdef(interface)
    suffix = _get_library_suffix()
    lib_file_name = os.path.join(library_dir,
                                 'lib{0}.{1}'.format(library, suffix))
    lib = ffi.dlopen(lib_file_name)
    return lib
