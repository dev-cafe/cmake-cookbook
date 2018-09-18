Memory defects, such as writing to or reading from memory beyond allocated
bounds, or memory leaks (memory that is allocated, but never released), can
create nasty bugs that are difficult to track down, and it is useful to detect
them early.

In this recipe, we show how to use [Valgrind](http://valgrind.org) to alert us
about memory problems when running tests using CMake/CTest.
