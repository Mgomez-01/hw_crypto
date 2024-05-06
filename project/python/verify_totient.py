from sympy import factorint, totient
import argparse

def main():
    parser = argparse.ArgumentParser(description="Encrypt or decrypt a file using a simple PRNG-based stream cipher.")
    parser.add_argument("k", type=int, help="The degree to evaluate.")
    parser.add_argument("base", type=int, help="The base to use.")

    # Calculate q^k - 1 for q = 37 and k = 4
    args = parser.parse_args()
    k = args.k
    base = args.base
    q_k_minus_1 = base**k - 1

    # Calculate Euler's totient function manually and check with sympy
    factorization = factorint(q_k_minus_1)
    phi_value = totient(q_k_minus_1)

    # Output the factorization and the calculated phi
    print("Factorization of q^k - 1:", factorization)
    print("Calculated phi using sympy:", phi_value)

    # Calculate phi manually from the factorization
    manual_phi = q_k_minus_1
    for p, exp in factorization.items():
        manual_phi *= (1 - 1/p)

    print(factorization.items())
    manual_phi = int(manual_phi)
    print(f"Manually calculated phi:{manual_phi}")

    print(f"div by {k} for the primitives:{manual_phi/k:_}")


if __name__ == "__main__":
    main()
