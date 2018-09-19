# Defining a unit test and linking against Google Test

In this recipe, we demonstrate how to implement unit testing using the [Google
Test](https://github.com/google/googletest) framework, with the help of CMake.

We will use [`FetchContent`](https://cmake.org/cmake/help/latest/module/FetchContent.html) to download a well-defined version of the Google
Test sources at configure time, and then build the framework and link against
it.


- [cxx-example](cxx-example/)
- [cxx-example-3.5](cxx-example-3.5/)
