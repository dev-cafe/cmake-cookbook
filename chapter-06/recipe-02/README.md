# Generating source code at configure time using Python

In this recipe, we generate `print_info.c` from the template `print_info.c.in`
by emulating the CMake function
[`configure_file`](https://cmake.org/cmake/help/latest/command/configure_file.html)
with a custom Python script.

The goal of this recipe is to learn how we can generate source code at
configure time.

We should point out that this recipe has a serious limitation and cannot
emulate
[`configure_file`](https://cmake.org/cmake/help/latest/command/configure_file.html)
fully. The approach that we present here cannot generate an automatic
dependency which would regenerate `print_info.c` at build time. In other words,
if you remove the generated `print_info.c` after the configure step, this file
will not be regenerated and the build step will fail.  To proper mimic the
behavior of
[`configure_file`](https://cmake.org/cmake/help/latest/command/configure_file.html)
we would require
[`add_custom_command`](https://cmake.org/cmake/help/latest/command/add_custom_command.html)
and
[`add_custom_target`](https://cmake.org/cmake/help/latest/command/add_custom_target.html),
which we will use in the subsequent [Recipe 3, *Generating source code at build
time using Python*](../recipe-03), where we will overcome this limitation.


- [fortran-c-example](fortran-c-example/)
