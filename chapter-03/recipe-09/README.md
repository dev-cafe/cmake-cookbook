# Detecting external libraries: I. Using `pkg-config`

This recipe shows how to detect the [ZeroMQ library](http://zeromq.org/) using CMake and `pkg-config`.
The recipe works on Unix-like systems, such as GNU/Linux and macOS.
For CMake 3.6 and higher, an [`IMPORTED` library](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#imported-targets) can be used, but an example
for older versions of CMake is also shown.


- [c-example](c-example/)
- [c-example-3.5](c-example-3.5/)
