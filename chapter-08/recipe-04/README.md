# Managing dependencies with a superbuild: III. The Google Test framework

In this recipe we reuse the code from [Recipe 3 in Chapter 4](../../chapter-04/recipe-03)
and fetch and build the [Google Test](https://github.com/google/googletest) framework
using [`FetchContent`](https://cmake.org/cmake/help/latest/module/FetchContent.html),
which provides a compact and
versatile module to assemble project dependencies at configure time. For additional insight
and for CMake below 3.11, we will also discuss how to emulate [`FetchContent`](https://cmake.org/cmake/help/latest/module/FetchContent.html) using
[`ExternalProject_Add`](https://cmake.org/cmake/help/latest/module/ExternalProject_Add.html)
at configure time.


- [cxx-example](cxx-example/)
- [cxx-example-3.5](cxx-example-3.5/)
