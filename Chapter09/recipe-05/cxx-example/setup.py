#!/usr/bin/env python

import os
import sys

from distutils.core import setup
from distutils import spawn
import distutils.command.build as _build
from distutils.sysconfig import get_python_lib


class build(_build.build):
    def run(self):
        cwd = os.getcwd()
        if spawn.find_executable('cmake') is None:
            sys.stderr.write("CMake is required to build this package.\n")
            sys.exit(-1)
        _source_dir = os.path.split(__file__)[0]
        _build_dir = os.path.join(_source_dir, 'build_setup_py')
        try:
            spawn.spawn(['cmake',
                         '-H{0}'.format(_source_dir),
                         '-B{0}'.format(_build_dir),
                         '-DCMAKE_INSTALL_PREFIX={0}'.format(get_python_lib()),
                         ])
            spawn.spawn(['cmake',
                         '--build', _build_dir,
                         '--target', 'install'])
            os.chdir(cwd)
        except spawn.DistutilsExecError:
            sys.stderr.write("Error while building with CMake\n")
            sys.exit(-1)
        _build.build.run(self)


setup(name='account',
      version='0.0.0',
      description='Description in here.',
      author='Bruce Wayne',
      author_email='me@example.org',
      url='http://example.org',
      packages=['account'],
      license='MIT',
      cmdclass={'build': build})
