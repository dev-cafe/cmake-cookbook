In this recipe, we reuse the approach from the previous example, but use
[ThreadSanitizer](https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
in combination with CTest and CDash, to identify data races and
report these to a CDash dashboard.
