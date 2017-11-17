#!/usr/bin/env python

import subprocess

output = subprocess.check_output(['./replicate', '2', 'one two three four'])
assert output == b'one two three four one two three four\n'

output = subprocess.check_output(['./replicate', '3', '1 2'])
assert output == b'1 2 1 2 1 2\n'
