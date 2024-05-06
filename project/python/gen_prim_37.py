import galois
import argparse

# Set up the argument parser
parser = argparse.ArgumentParser(description="List primitive polynomials of a specified degree for GF(37).")
parser.add_argument("degree", type=int, help="The degree of the polynomial.")

# Parse the arguments
args = parser.parse_args()

# Main functionality
for i, p in enumerate(galois.primitive_polys(37, args.degree)):
    print(args.degree, i, p)
