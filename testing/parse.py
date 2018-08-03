import os
import pathlib


def parse_yaml(file_name):
    '''
    Parse file_name and return dictionary.
    If file does not exist, return empty dictionary.
    '''
    import yaml
    import sys
    if file_name.is_file():
        with file_name.open() as f:
            try:
                config = yaml.load(f, yaml.SafeLoader)
            except yaml.YAMLError as exc:
                print(exc)
                sys.exit(-1)
        return config
    return {}


def extract_menu_file(file_name, generator, ci_environment):
    '''
    Reads file_name in yml format and returns:
    skip (bool): if True, then skip the current generator
    expected_failure (bool): if True, then the current generator is not supported
    env: dictionary of environment variables passed to CMake
    definitions: dictionary of CMake configure-step definitions
    targets: list of targets to build
    '''
    config = parse_yaml(file_name)

    # assemble targets
    targets = []
    if 'targets' in config:
        for entry in config['targets']:
            targets.append(entry)

    if ci_environment not in config:
        return False, False, {}, {}, targets

    skip_generators = []
    if 'skip_generators' in config[ci_environment]:
        skip_generators = config[ci_environment]['skip_generators']
    skip = generator in skip_generators

    failing_generators = []
    if 'failing_generators' in config[ci_environment]:
        failing_generators = config[ci_environment]['failing_generators']
    expect_failure = generator in failing_generators

    # assemble env vars
    env = {}
    if 'env' in config[ci_environment]:
        for entry in config[ci_environment]['env']:
            for k, v in entry.items():
                env[k] = v

    # assemble definitions
    definitions = {}
    if 'definitions' in config[ci_environment]:
        for entry in config[ci_environment]['definitions']:
            for k, v in entry.items():
                definitions[k] = v

    return skip, expect_failure, env, definitions, targets
