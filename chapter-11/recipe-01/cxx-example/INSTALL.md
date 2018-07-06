# Installing `message`

The library uses CMake as its build system. The minimum required version is
CMake 3.6
You can configure with:
```
cmake -H. -Bbuild -DCMAKE_INSTALL_PREFIX=/path/to/install/message
```
and build and install with:
```
cmake --build build --target install
```

If for any reason you want to regenerate the source `.tar.gz` and `.zip` packages:
```
cmake --build build --target package_source
```
