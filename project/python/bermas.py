def berlekamp_massey(sequence):
    N = len(sequence)
    C = [1]  # Initial connection polynomial C(x) = 1
    B = [1]  # Temporary polynomial B(x) = 1
    L = 0    # Current LFSR length
    m = 1    # Delay count for the discrepancy
    b = 1    # Last non-zero discrepancy (in F_2, non-zero is always 1)

    # Main loop over the sequence length
    for n in range(N):
        # Calculate the discrepancy d
        d = sequence[n]
        for i in range(1, L + 1):
            if i <= n and C[i] == 1:
                d ^= sequence[n - i]

        if d == 0:
            m += 1
        else:
            if 2 * L <= n:
                T = C.copy()
                # Extend C(x) by zeros to make sure it's long enough
                while len(C) < len(B) + m:
                    C.append(0)
                # Update C(x) by adding x^m * B(x)
                for i in range(len(B)):
                    C[i + m] ^= B[i]

                L = n + 1 - L
                B = T
                b = d  # In F_2, d is always 1 here
                m = 1
            else:
                # Extend C(x) by zeros to make sure it's long enough
                while len(C) < len(B) + m:
                    C.append(0)
                # Only update C(x) without changing L or B
                for i in range(len(B)):
                    C[i + m] ^= B[i]
                m += 1

    return C, L

def print_polynomial(coeffs):
    # Reverse the list to print from highest to lowest degree
    coeffs = coeffs[::-1]
    terms = []
    for i, coeff in enumerate(coeffs):
        if coeff != 0:
            if i == 0:
                terms.append(str(coeff))
            elif i == 1:
                terms.append("x")
            else:
                terms.append(f"x^{i}")
    polynomial = " + ".join(terms)
    return polynomial


# Example usage
sequence = [1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1]  # Given binary sequence
minimal_poly, L = berlekamp_massey(sequence)
print("Minimal Polynomial Coefficients:", minimal_poly[::-1])
print("Length of the LFSR (L):", L)
print(print_polynomial(minimal_poly[::-1]))
