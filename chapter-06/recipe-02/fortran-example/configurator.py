#!/usr/bin/env python

import os
import sys
import re
import getpass
import platform
import datetime
import socket

def configure_file(rep, fname, **kwargs):
    ''' Configure a file.
    This functions acts more or less like CMake's configure_file command.

    :param rep:
       a {placeholder : replacement} dictionary
    :param fname:
       name of the file to be configured, without suffix
    :param \**kwargs:
       See below

    :Keyword arguments:
       * *in_path*  -- directory for the unconfigured file
       * *suffix*   -- suffix of the unconfigured file, with separators
       * *prefix*   -- prefix for the configured file
       * *out_path* -- directory for the configured file
    '''
    in_path = kwargs.get('in_path', os.getcwd())
    suffix = kwargs.get('suffix', '.in')
    out_path = kwargs.get('out_path', in_path)
    prefix = kwargs.get('prefix', '')
    fname_in = fname + suffix
    filedata = ''
    with open(os.path.join(in_path, fname_in), 'r') as fin:
        filedata = fin.read()
    rep = dict((re.escape(k), v) for k, v in rep.items())
    pattern = re.compile("|".join(list(rep.keys())))
    filedata = pattern.sub(lambda m: rep[re.escape(m.group(0))], filedata)
    fname_out = prefix + fname
    with open(os.path.join(out_path, fname_out), 'w+') as fout:
        fout.write(filedata)

def prepare_configuration_dictionary(**kwargs):
    '''
    :Keyword arguments:
       * *processor_name*
       * *processor_description*
       * *os_name*
       * *os_release*
       * *os_version*
       * *os_platform*
       * *cmake_version*
       * *cmake_generator*
       * *fc*
       * *cc*
    '''

    processor_name = kwargs.get('processor_name', 'unknown')
    processor_description = kwargs.get('processor_description', 'unknown')
    os_name = kwargs.get('os_name', 'unknown')
    os_release = kwargs.get('os_release', 'unknown')
    os_version = kwargs.get('os_version', 'unknown')
    os_platform = kwargs.get('os_platform', 'unknown')
    cmake_version = kwargs.get('cmake_version', 'Not built using CMake')
    cmake_generator = kwargs.get('cmake_generator', 'Not built using CMake')
    Fortran_compiler = kwargs.get('fc', 'unknown')
    C_compiler = kwargs.get('cc', 'unknown')

    conf_dict = {
        '@_user_name@' : getpass.getuser(),
        '@_host_name@' : platform.node(),
        '@_fqdn@' : socket.getfqdn(),
        '@_os_name@' : os_name,
        '@_os_release@' : os_release,
        '@_os_version@' : os_version,
        '@_os_platform@' : os_platform,
        '@_processor_name@' : processor_name,
        '@_processor_description@' : processor_description,
        '@_cmake_version@' : cmake_version,
        '@_cmake_generator@' : cmake_generator,
        '@_configuration_time@' : datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S [UTC]'),
        '@_Fortran_compiler@' : Fortran_compiler,
        '@_C_compiler@' : C_compiler,
    }

    return conf_dict
