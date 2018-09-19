This example will embed a Python interpreter into a C++ executable and run a
custom Python script.
The Python script uses [Numpy](http://www.numpy.org/) and we will show how to find this module with CMake
with help of [`find_package_handle_standard_args`](https://cmake.org/cmake/help/latest/module/FindPackageHandleStandardArgs.html).

To test run: `./pure-embedding use_numpy print_ones 15 34`
