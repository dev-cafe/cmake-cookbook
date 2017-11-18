#!/usr/bin/env python

import subprocess
import argparse

# this test script expects an argument
parser = argparse.ArgumentParser()
parser.add_argument('--short',
                    default=False,
                    action='store_true',
                    help='only run the short test')
args = parser.parse_args()


def execute_cpp_code(integers):
    result = subprocess.check_output(['./sum_up'] + integers)
    return int(result)


if args.short:
    # we collect [1, 2, ..., 100] as a list of strings
    result = execute_cpp_code([str(i) for i in range(1, 101)])
    assert result == 5050
else:
    # we collect [1, 2, ..., 1000] as a list of strings
    result = execute_cpp_code([str(i) for i in range(1, 1001)])
    assert result == 500500
