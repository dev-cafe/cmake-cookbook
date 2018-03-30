# Probing compiler flags

We show the usage of `check_<lang>_compiler_flag` to check for the availability
of compiler flags. The example will show how to set compiler flags for the
sanitizers (address, memory, thread and undefined behavior) which require the
flag to be passed also to the linker.
This function is available for Fortran since CMake 3.3.


- [cxx-example](cxx-example/)
