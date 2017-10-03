# Dealing with platform-dependent source code

Ideally we should avoid platform-dependent source code but sometimes we have no choice - in particular
if we are given a code to configure and compile which we have not written.
In this recipe we will demonstrate how to use CMake to conditionally compile source code section
depending on the operating system.


## Ingredients

- A C++ compiler
- CMake (any version higher than 3.0)


## How to do it

For this example we will use a slight modification of the previous recipe.

Let us consider the following `hello-world.cpp` source code:

```cpp
#include <cstdlib>
#include <iostream>
#include <string>

std::string say_hello() {
#ifdef IS_WINDOWS
  return std::string("Hello from Windows!");
#elif IS_LINUX
  return std::string("Hello from Linux!");
#elif IS_MAC
  return std::string("Hello from Mac!");
#else
  return std::string("Hello from an unknown system!");
#endif
}

int main() {
  std::cout << say_hello() << std::endl;
  return EXIT_SUCCESS;
}
```

We will configure this code using the following `CMakeLists.txt`:

```cmake
# set minimum cmake version
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# project name and language
project(recipe-0011 CXX)

# let the preprocessor know about the system name
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    add_definitions(-DIS_LINUX)
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
    add_definitions(-DIS_MAC)
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    add_definitions(-DIS_WINDOWS)
endif()

# define executable and its source file
add_executable(hello-world hello-world.cpp)
```

Again, before testing this example, first examine the two files above and
consider what behavior you expect on your system. After doing that we are ready
to test it out and to configure the project (output from CMake is omitted):

```
$ cmake -H. -Bbuild
$ cd build
$ cmake --build .
$ ./hello-world

Hello from Linux!
```

On a Windows system you will see "Hello from Windows!" instead and on Mac OS X a different output accordingly.


## How it works

The interesting part in the `hello-world.cpp` example is the conditional
compilation based on the preprocessor definitions `IS_WINDOWS`, `IS_LINUX`, or
`IS_MAC`. These are defined at configure time by CMake in `CMakeLists.txt` and
passed on to the preprocessor.

```cmake

# let the preprocessor know about the system name
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    add_definitions(-DIS_LINUX)
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
    add_definitions(-DIS_MAC)
endif()
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    add_definitions(-DIS_WINDOWS)
endif()
```

## Tips

Minimize platform-dependent source code in your project to simplify porting effort.
