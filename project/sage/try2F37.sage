from sage.rings.polynomial.polynomial_ring_constructor import PolynomialRing
from sage.rings.finite_rings.finite_field_constructor import FiniteField

# Define the field F_37
F37 = FiniteField(37)
P.<x> = PolynomialRing(F37)

# Function to find and verify a primitive polynomial of degree k
def find_and_verify_primitive_polynomial(degree):
    assert degree > 0, "Degree must be positive"
    R.<x> = PolynomialRing(F37)
    F37k = FiniteField(37**degree, 'alpha')

    # Attempt to find a primitive polynomial by random sampling
    attempts = 0
    while attempts < 100:  # Limit the number of attempts to avoid infinite loops
        poly = R.random_element(degree)  # Generate a random polynomial of given degree
        print(f"testing poly:{poly}")
        if poly.is_irreducible():  # Check if the polynomial is irreducible
            print(f"---Is irreducible")
            # Try to use this polynomial to construct the extension field
            try:
                # This will fail if the polynomial is not suitable for constructing the field
                E = F37.extension(poly, 'alpha')
                alpha = E.gen()
                # Generate all powers of alpha
                elements = set(alpha**i for i in range(1, 37**degree))
                # Check if we have covered all non-zero elements of the field
                if len(elements) == 37**degree - 1:
                    print(f"---Contains correct number of generated elements.")
                    print(f"Primitive polynomial found: {poly}")
                    return poly
                else:
                    print(f"Polynomial {poly} is irreducible but not primitive.")
            except:
                print(f"Failed to construct field with polynomial {poly}")
        attempts += 1
        print(f"---Not irreducible")
    return None

# Example usage: find and verify a primitive polynomial of degree 2 in F_37
degree_k = 4
primitive_poly = find_and_verify_primitive_polynomial(degree_k)
if primitive_poly:
    print(f"Verified primitive polynomial of degree {degree_k} in F_37 is: {primitive_poly}")
else:
    print("No primitive polynomial found after 100 attempts.")
