"""
Generates C++ vector of prime numbers up to max_number
using sieve of Eratosthenes.
"""
import pathlib
import sys

# for simplicity we do not verify argument list
max_number = int(sys.argv[-2])
output_file_name = pathlib.Path(sys.argv[-1])

numbers = range(2, max_number + 1)
is_prime = {number: True for number in numbers}

for number in numbers:
    current_position = number
    if is_prime[current_position]:
        while current_position <= max_number:
            current_position += number
            is_prime[current_position] = False

primes = (number for number in numbers if is_prime[number])
code = """#pragma once

#include <vector>

const std::size_t max_number = {max_number};

std::vector<int> & primes() {{
  static std::vector<int> primes;

{push_back}

  return primes;
}}
"""
push_back = '\n'.join(['  primes.push_back({:d});'.format(x) for x in primes])
output_file_name.write_text(
    code.format(max_number=max_number, push_back=push_back))
