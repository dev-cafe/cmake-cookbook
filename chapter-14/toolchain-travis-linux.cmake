# the name of the target operating system
set(CMAKE_SYSTEM_NAME Windows)

# which compilers to use
set(CMAKE_C_COMPILER i686-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER i686-w64-mingw32-g++)
set(CMAKE_Fortran_COMPILER i686-w64-mingw32-gfortran)

# here is the target environment located
#set(CMAKE_FIND_ROOT_PATH /path/to/target/environment)

# adjust the default behaviour of the find commands:
# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
