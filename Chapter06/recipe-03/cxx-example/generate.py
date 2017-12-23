"""
Generates C++ vector of prime numbers up to max_number
using sieve of Eratosthenes.
"""
import sys

# for simplicity we do not verify argument list
max_number = int(sys.argv[-2])
output_file_name = sys.argv[-1]

numbers = range(2, max_number + 1)
is_prime = {number: True for number in numbers}

for number in numbers:
    current_position = number
    if is_prime[current_position]:
        while current_position <= max_number:
            current_position += number
            is_prime[current_position] = False

primes = (number for number in numbers if is_prime[number])
with open(output_file_name, 'w') as f:
    f.write('const size_t max_number = {0};\n'.format(max_number))
    f.write('std::vector<size_t> & primes() {\n')
    f.write('  static std::vector<size_t> primes;\n')
    for number in primes:
        f.write('  primes.push_back({0});\n'.format(number))
    f.write('  return primes;\n}')
