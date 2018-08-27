import subprocess
import sys

# for simplicity we do not check number of
# arguments and whether the file really exists
file_path = sys.argv[-1]

try:
    output = subprocess.check_output(['size', file_path]).decode('utf-8')
except FileNotFoundError:
    print('command "size" is not available on this platform')
    sys.exit(0)

size = 0.0
for line in output.split('\n'):
    if file_path in line:
        # we are interested in the 4th number on this line
        size = int(line.split()[3])

print('{0:.3f} MB'.format(size/1.0e6))
