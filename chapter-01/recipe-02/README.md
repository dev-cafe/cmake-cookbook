# Switching generators

A single `CMakeLists.txt` can be used to configure projects for different
toolstacks on different platforms.  CMake is a build system _generator_.
Starting from a description of the operations the build system, _e.g._ Unix
Makefiles, Ninja, Visual Studio, etc., will have to run to get your code
compiled, CMake _generates_ the corresponding instructions for the chosen build
system.

CMake supports an [extensive list](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html) of
native build tools for the different platforms. It is possible to get a list of
the available ones for the currently installed version of CMake on the current
platform by running:
```
cmake --help
```

As an example, to use the Ninja generator, configure with:

```
cmake -H. -Bbuild -GNinja
```


- [c-example](c-example/)
- [cxx-example](cxx-example/)
- [fortran-example](fortran-example/)
