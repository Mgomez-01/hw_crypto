# F37.sage
from sage.all import *
import time

# Set up the finite field F_37
F = FiniteField(37)

# Set up the polynomial ring over F_37
R.<x> = PolynomialRing(F)

# Function to find a primitive polynomial of a given degree k
def find_primitive_polynomial(k):
    # Generate all combinations of coefficients from F^(k+1)
    for coeffs in cartesian_product([F for _ in range(k+1)]):
        # Ensure the leading coefficient is not zero to maintain the degree
        if coeffs[0] == 0:
            continue
        # Construct the polynomial from coefficients
        poly = sum([coeffs[i] * x^i for i in range(k+1)])
        # Check if the polynomial is primitive
        if poly.is_primitive():
            return poly  # Return the first primitive polynomial found
    return None  # Return None if no primitive polynomial found

# Example: find a primitive polynomial of degree 3 in F_37[x]
# Loop to find primitive polynomials for different degrees and time each search
for i in range(37):
    start_time = time.time()  # Start timing
    primitive_poly = find_primitive_polynomial(i)
    end_time = time.time()  # End timing
    duration = end_time - start_time  # Calculate duration
    
    if primitive_poly:
        print(f"Primitive polynomial found for degree {i}: {primitive_poly} (Time taken: {duration:.2f} seconds)")
    else:
        print(f"No primitive polynomial found for the degree {i}. (Time taken: {duration:.2f} seconds)")