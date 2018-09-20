# Recording the project version from a file

The goal of this recipe is similar to [Recipe 4, *Recording the project version information for reproducibility*](../recipe-04),
but the starting point is different; our plan is to read the version information from a
file, rather than setting it inside of `CMakeLists.txt`.

The motivation for keeping the version in a separate file, outside of CMake
sources, is to allow other build frameworks or development tools to use the
information, independent of CMake, without duplicating the information in
several files.


- [cxx-example](cxx-example/)
