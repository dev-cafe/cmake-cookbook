We show the usage of `check_<lang>_compiler_flag`
(where `<lang>` can be [C](https://cmake.org/cmake/help/latest/module/CheckCCompilerFlags.html),
[CXX](https://cmake.org/cmake/help/latest/module/CheckCXXCompilerFlags.html) or
[Fortran](https://cmake.org/cmake/help/latest/module/CheckFortranCompilerFlags.html))
to check for the availability of compiler flags.
The example will show how to set compiler flags for the sanitizers (address,
memory, thread and undefined behavior) which require the flag to be passed also
to the linker.
This function is available for Fortran since CMake 3.3.

We will expand on this example in [Recipe 3 in Chapter 7](../../chapter-07/recipe-03)
