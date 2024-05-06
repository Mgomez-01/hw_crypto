import time
from functools import lru_cache
import math



# ANSI escape codes for colors
class colors:
    RESET = "\033[0m"
    BLACK = "\033[30m"
    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    MAGENTA = "\033[35m"
    CYAN = "\033[36m"
    WHITE = "\033[37m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"

@lru_cache(maxsize=None)
def genCayley(N):
    for i in range(1, N):
        str = ''
        for j in range(1, N):
            if (i*j)%N == 0:
                str += f'{colors.BLUE}|||{colors.RESET}'
            elif (i*j)%N == 1:
                str += f'{colors.RED}XXX{colors.RESET}'
            elif (i*j)%N == 2:
                str += f'{colors.GREEN}CCC{colors.RESET}'
            else:
                str += '   '
        print(str)

@lru_cache(maxsize=None)
def is_prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True

def prime_generator():
    yield 2  # Yield the first prime number

    number = 3
    while True:
        if is_prime(number):
            yield number
        number += 2  # Skip even numbers since they cannot be prime


# Example usage:
primes = prime_generator()
for _ in range(4000):
    print(next(primes), end=' ')  # Print the first 20 prime numbers



exit(0)
#print(dir(time))
for i in range(1, 180):
    for k in range(0, 1500):
        if k%i == 0:
             genCayley(i)
        time.sleep(.00001)
