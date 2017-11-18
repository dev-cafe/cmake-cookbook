#!/usr/bin/env python

import subprocess

# [1, 2, ..., 100]
# we collect these as a list of strings
integers = [str(i) for i in range(1, 101)]

output = subprocess.check_output(['./sum_up'] + integers)
output = int(output)

assert output == 5050
