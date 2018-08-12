import os


def get_ci_environment():
    if os.environ.get('TRAVIS'):
        travis_os_name = os.environ.get('TRAVIS_OS_NAME')
        if travis_os_name == 'osx':
            ci_environment = 'travis-osx'
        else:
            ci_environment = 'travis-linux'
    elif os.environ.get('APPVEYOR'):
        generator = os.environ.get('CMAKE_GENERATOR')
        if 'Visual Studio' in generator:
            ci_environment = 'appveyor-vs'
        else:
            ci_environment = 'appveyor-msys'
    elif os.environ.get('CIRCLECI'):
        circle_compiler = os.environ.get('CIRCLECI_COMPILER')
        if circle_compiler == 'intel':
            ci_environment = 'circle-intel'
        else:
            ci_environment = 'circle-pgi'
    else:
        ci_environment = 'local'
    return ci_environment


def get_generator():
    generator = os.environ.get('CMAKE_GENERATOR')
    if generator is None:
        generator = 'Unix Makefiles'
    return generator


def get_buildflags():
    buildflags = os.environ.get('BUILDFLAGS')
    if buildflags is None:
        # this fails on my laptop with Unix Makefiles (?)
        #       buildflags = '-v'
        buildflags = ''
    return buildflags


def is_defined(env_var):
    truthy = ['1', 'TRUE', 'ON', 'YES', 'Y']
    falsey = ['0', 'FALSE', 'OFF', 'NO', 'N']

    defined = False
    if os.environ.get(env_var) is None:
        defined = False
    elif os.environ.get(env_var).upper() in falsey:
        defined = False
    elif os.environ.get(env_var).upper() in truthy:
        defined = True
    else:
        defined = False

    return defined


def verbose_output():
    return is_defined('VERBOSE_OUTPUT')


def die_hard():
    return is_defined('DIE_HARD')
