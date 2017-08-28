#!/usr/bin/env bash

# The return code will capture an error from ANY of the functions in the pipe
set -euo pipefail
# Report versions of whole tool stack
# CMake
cmake --version
# Generators
if [[ "${GENERATOR}" == "Unix Makefiles" ]]; then
  make --version
else
  ninja --version
fi
