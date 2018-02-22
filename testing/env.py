import os


def get_ci_environment():
    if os.environ.get('TRAVIS'):
        travis_os_name = os.environ.get('TRAVIS_OS_NAME')
        if travis_os_name == 'osx':
            ci_environment = 'travis-osx'
        else:
            ci_environment = 'travis-linux'
    elif os.environ.get('APPVEYOR'):
        ci_environment = 'appveyor'
    elif os.environ.get('DRONE'):
        ci_environment = 'drone'
    else:
        ci_environment = 'local'
    return ci_environment


def get_generator():
    generator = os.environ.get('GENERATOR')
    if generator is None:
        generator = 'Ninja'
    return generator


def get_buildflags():
    buildflags = os.environ.get('BUILDFLAGS')
    if buildflags is None:
        # this fails on my laptop with Unix Makefiles (?)
        #       buildflags = '-v'
        buildflags = ''
    return buildflags


def get_topdir():
    if os.environ.get('TRAVIS'):
        topdir = os.environ.get('TRAVIS_BUILD_DIR')
    elif os.environ.get('APPVEYOR'):
        topdir = os.environ.get('APPVEYOR_BUILD_FOLDER')
    elif os.environ.get('DRONE'):
        topdir = os.getcwd()
    else:
        topdir = os.getcwd()
    return topdir
