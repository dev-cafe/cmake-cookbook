This recipe discusses an alternative way to organize the CMake build system for large code
projects. We will show how to use [`target_sources`] and [`include`] to limit the scope of
variables, lower CMake code complexity, and simplify maintenance.
We will compare this approach with the one taken in [Recipe 7](../recipe-07)

[`target_sources`]: https://cmake.org/cmake/help/latest/command/target_sources.html
[`include`]: https://cmake.org/cmake/help/latest/command/include.html
