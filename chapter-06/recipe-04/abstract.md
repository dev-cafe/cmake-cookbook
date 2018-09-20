In this example, we define the project version number inside of the CMake
sources. Our goal is to record the program version to a header file at the
moment when we configure the project. The generated header file can then be
included in the code at the right place and time, to print the code version to
the output file(s) or screen.
