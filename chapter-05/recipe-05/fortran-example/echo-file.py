import sys

# for simplicity we do not check number of
# arguments and whether the file really exists
file_path = sys.argv[-1]

with open(file_path, 'r') as f:
    print(f.read())
