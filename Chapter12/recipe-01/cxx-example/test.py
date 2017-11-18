#!/usr/bin/env python

import subprocess

# [1, 2, ..., 100]
# we collect these as a list of strings
one_to_hundred = [str(i) for i in range(1, 101)]

output = subprocess.check_output(['./sum_up'] + one_to_hundred)
output = int(output)

assert output == 5050
