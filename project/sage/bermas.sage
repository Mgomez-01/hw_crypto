from sage.all import *

def berlekamp_massey(s, K):
    """
    Berlekamp-Massey Algorithm to find the minimal polynomial of a sequence in a field K.

    :param s: The sequence (list of elements from K) for which to find the minimal polynomial.
    :param K: The field over which the sequence and polynomials are defined.
    :return: The minimal polynomial for the sequence.
    """
    N = len(s)  # Length of the sequence
    R = PolynomialRing(K, 'x')  # Polynomial ring over the field K
    x = R.gen()  # Generator for the polynomial ring
    C = R.one()  # Connection polynomial, initially 1
    B = R.one()  # Temporary polynomial, initially 1
    L = 0  # Current LFSR length
    m = 1  # Delay count for the discrepancy
    b = K(1)  # Last non-zero discrepancy, initially as field element

    # Convert sequence to field elements if not already
    s = [K(coef) for coef in s]

    # Process each term in the sequence
    for n in range(N):
        d = s[n] + sum(C[i] * s[n - i] for i in range(1, min(L + 1, n + 1)))  # Calculate discrepancy

        if d.is_zero():
            m += 1  # Increment m if discrepancy is zero
        elif d.is_one():
            d_inv = d  # Compute inverse of d
            if 2 * L <= n:
                T = C  # Temporary copy of C
                C = C - d_inv * (x ** m) * B  # Update C(x)
                L = n + 1 - L  # Update L
                B = T  # Update B
                b = d  # Update b
                m = 1  # Reset m
            else:
                C = C - d_inv * (x ** m) * B  # Update C(x)
                m += 1  # Increment m
        else:
            d_inv = d.inverse()  # Compute inverse of d
            if 2 * L <= n:
                T = C  # Temporary copy of C
                C = C - d_inv * (x ** m) * B  # Update C(x)
                L = n + 1 - L  # Update L
                B = T  # Update B
                b = d  # Update b
                m = 1  # Reset m
            else:
                C = C - d_inv * (x ** m) * B  # Update C(x)
                m += 1  # Increment m

    return C, L  # Return the connection polynomial and L

# Example usage in a field GF(2)
K = GF(2)
sequence = [1, 0, 0, 1, 1, 0, 1, 0, 1]
minimal_poly, L = berlekamp_massey(sequence, K)
print("Minimal Polynomial:", minimal_poly)
print("Length of the LFSR:", L)
