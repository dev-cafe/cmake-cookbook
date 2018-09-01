import shlex
import subprocess
import sys


def main():
    patcher = sys.argv[1]
    elfobj = sys.argv[2]

    tools = {'patchelf': '--print-rpath', 'chrpath': '--list', 'otool': '-L'}
    if patcher not in tools.keys():
        raise RuntimeError('Unknown tool {}'.format(patcher))
    cmd = shlex.split('{:s} {:s} {:s}'.format(patcher, tools[patcher], elfobj))
    rpath = subprocess.run(
        cmd,
        bufsize=1,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True)
    print(rpath.stdout)


if __name__ == "__main__":
    main()
