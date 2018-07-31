import functools
import pathlib
import shlex
import subprocess
import sys


def streamer(line, *, file_handle=sys.stdout, end='', verbose=True):
    """
    Stream a line to file_handle and return the line.
    """
    if verbose:
        print(line, file=file_handle, end=end)
    return line


def run_command(*, command):
    """
    patcher: string; ELF patching utility to use (valid options: patchelf, chrpath, install_name_tool)
    """
    cmd = shlex.split(command)
    stdout_streamer = streamer
    stderr_streamer = functools.partial(streamer, file_handle=sys.stderr)
    stdout = ''
    stderr = ''
    with subprocess.Popen(
            cmd,
            bufsize=1,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True) as child:
        stdout += ''.join(list(map(stdout_streamer, child.stdout)))
        stderr = ''.join(list(map(stderr_streamer, child.stderr)))

    if child.returncode == 0:
        streamer('DONE with {}'.format(command), end='\n')
    else:
        streamer(
            '{cmd}\n {out}{err}'.format(cmd=command, out=stdout, err=stderr),
            end='\n')
        raise subprocess.CalledProcessError(child.returncode, child.args)

    return stdout


def main():
    patcher = sys.argv[1]
    to_remove = sys.argv[2]
    to_add = sys.argv[3]
    elfobj = sys.argv[4]
    if patcher == 'patchelf':
        streamer('Using patchelf', end='\n')
        old_rpath = run_command(command='{} --print-rpath {}'.format(patcher, elfobj))
        new_rpath = old_rpath.replace(to_remove, to_add)
        _ = run_command(command='{} --set-rpath {} {}'.format(patcher, new_rpath, elfobj))
        _ = run_command(command='{} --shrink-rpath {}'.format(patcher, elfobj))
        _ = run_command(command='{} --print-rpath {}'.format(patcher, elfobj))
    elif patcher == 'chrpath':
        streamer('Using chrpath', end='\n')
        old_rpath = run_command(command='{} --list {}'.format(patcher, elfobj))
        old_rpath = old_rpath.replace('{}: RUNPATH='.format(elfobj), '')
        new_rpath = old_rpath.replace(to_remove, to_add)
        _ = run_command(command='{} --replace {} {}'.format(patcher, new_rpath, elfobj))
        _ = run_command(command='{} --list {}'.format(patcher, elfobj))
    elif patcher == 'install_tool_name':
        streamer('Using install_tool_name', end='\n')
        _ = run_command(command='{} -delete_rpath {} {}'.format(patcher, to_remove, elfobj))
        _ = run_command(command='{} -add_rpath {} {}'.format(patcher, to_add, elfobj))
    else:
        raise RuntimeError('Unknown tool {}'.format(sys.argv[1]))


if __name__ == "__main__":
    main()
