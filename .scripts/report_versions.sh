#!/usr/bin/env bash

# The return code will capture an error from ANY of the functions in the pipe
set -euo pipefail

echo "Report versions of whole tool stack"

for tool in cmake make ninja; do
    echo ""
    echo "Checking version of $tool:"
    $tool --version 2> /dev/null || echo "$tool not available"
done
