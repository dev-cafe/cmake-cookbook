# Discovering the operating system

CMake is a set of cross-platform tools. Nevertheless it can be very useful to
know on which operating system (OS) the configure or build step is executed:
either to tweak CMake code for a particular OS, to enable conditional
compilation depending on the OS or to use compiler-specific extensions if
available. In this recipe we will demonstrate how to use CMake to detect the
OS.


## Ingredients

- A C++ compiler
- CMake (any version higher than 3.0)


## How to do it

For this example we will use the following `CMakeLists.txt` together with a
`hello-world.cpp` that we can reuse from recipe X (ADD LINK) although the C++
source code does not matter for the essence of this recipe and you can even
leave it out and comment out the last line containing
`add_executable(hello-world hello-world.cpp)`.

```cmake
# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0011 CXX)

# detect operating system
message(STATUS "We are on a ${CMAKE_SYSTEM_NAME} system")

# print custom message depending on the operating system
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    message(STATUS "On Linux print this message")
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
    message(STATUS "On Mac OS X print this message")
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    message(STATUS "On Windows print this message")
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "AIX")
    message(STATUS "On IBM AIX print this message")
endif()

# define executable and its source file
add_executable(hello-world hello-world.cpp)
```

Before testing it out first examine the `CMakeLists.txt` file above and
consider what behavior you expect on your system. After doing that we are ready
to test it out and configure the project:

```
$ cmake -H. -Bbuild

-- The CXX compiler identification is GNU 5.4.0
-- Check for working CXX compiler: /run/current-system/sw/bin/c++
-- Check for working CXX compiler: /run/current-system/sw/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- We are on a Linux system
-- On Linux print this message
-- Configuring done
-- Generating done
-- Build files have been written to: /home/bast/tmp/cmake-recipes/Chapter02/recipe-0011/cxx-example/build
```

Among the output two lines are interesting here - on a Linux system these are:

```
-- We are on a Linux system
-- On Linux print this message
```

On other systems the output will hopefully be different.


## How it works

CMake correctly defines `${CMAKE_SYSTEM_NAME}` for the target OS and therefore
there is typically no need to use custom commands to query this information.
The value of this variable can then be used to implement OS-specific
conditionals and workarounds.  On systems that have the `uname` command, this
variable is set to the output of `uname -s`.  The variable is set to "Darwin"
on Mac OS X. On Linux and Windows it evaluates to "Linux" and "Windows".


## Tips

To minimize trouble when moving from one platform to another, you should avoid
using shell commands directly and also avoid explicit path delimiters (forward
slashes on Linux and Mac OS X and backward slashes on Windows). In CMake code
only use forward slashes as path delimiters and CMake will automatically
translate them to the OS in question.
