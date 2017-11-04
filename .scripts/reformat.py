import sys

lines = sys.stdin.read().splitlines()

for i, section in enumerate(['appveyor', 'drone', 'travis-linux', 'travis-osx', 'local']):
    if i == 0:
        separator = ''
    else:
        separator = '\n'
    print('{0}{1}:'.format(separator, section))
    for line in lines:
        print('  {0}'.format(line))
