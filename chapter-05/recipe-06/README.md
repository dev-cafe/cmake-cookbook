# Probing compilation and linking

We show the usage of `check_<lang>_source_compiles` (where `<lang>` can be [C](https://cmake.org/cmake/help/latest/module/CheckCSourceCompiles.html),
[CXX](https://cmake.org/cmake/help/latest/module/CheckCXXSourceCompiles.html) or
[Fortran](https://cmake.org/cmake/help/latest/module/CheckFortranSourceCompiles.html)) to check that a small code
snippet compiles. This will be contrasted with [`try_compile`]. Finally, we
discuss how to troubleshoot [`try_compile`] to avoid false negatives and false positives.

[`try_compile`]: https://cmake.org/cmake/help/latest/command/try_compile.html


- [cxx-example](cxx-example/)
- [cxx-example-3.5](cxx-example-3.5/)
