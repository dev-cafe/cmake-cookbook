Controlling Compiler Flags
==========================

This recipe shows how to set compiler flags for targets using
`target_compile_options()`. The compiler options set are only valid for GCC and
Clang, thus building this project **fails**  on Visual Studio.

The ideal way of setting compiler flags:
- Define a set of `${PROJECT_NAME}_<LANG>_FLAGS_<CONFIG>`. These will be your
  own flags for the project.
  Notice that it is possible to add your own build types. [See here](https://stackoverflow.com/a/11437693)

If using C++ or C, use the mechanism, available in CMake 3.1 and later,
to set the language standard and the features:
- Set compiler flags for the language standard using
  ```
  set_target_properties(foo
    PROPERTIES
      CXX_STANDARD 11
      CXX_EXTENSIONS OFF
      CXX_STANDARD_REQUIRED ON
    )
  ```
- Request features, with the `PUBLIC`, `PRIVATE` and `INTERFACE` specifiers
  ```
  target_compile_features(foo
    PUBLIC
      cxx_strong_enums
    PRIVATE
      cxx_lambdas
      cxx_range_for
    )
  ```
  This makes explicit what is needed to build and to use the target. Moreover,
  CMake has a nice mechanism to take care of optional compile features.
- Set compiler flags per target `target_compile_options()` using `PUBLIC`,
  `PRIVATE`, `INTERFACE` and _generator expressions_
  ```
  target_compile_options(foo
    PRIVATE
      "$<$<CONFIG:DEBUG>:${${PROJECT_NAME}_<LANG>_FLAGS_DEBUG}>"
  )
  target_compile_options(foo
    PRIVATE
      "$<$<CONFIG:RELEASE>:${${PROJECT_NAME}_<LANG>_FLAGS_RELEASE}>"
  )
  ```
