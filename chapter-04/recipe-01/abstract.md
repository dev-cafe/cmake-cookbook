In this recipe we use CTest to unit test a simple example code which sums all
natural numbers from 1 to 100.

To show that CMake does not impose any restrictions on the language to
implement the actual tests, the example code is tested using not only a C++
executable, but also using a Python script and a shell script. For simplicity,
this is demonstrated without using any testing libraries.
