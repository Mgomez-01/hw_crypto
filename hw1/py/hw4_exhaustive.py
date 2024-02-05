import numpy as np
from math import gcd
from rich import print

# Since Python doesn't have a built-in function to set cores directly like Singular, we'll skip those operations.
modulus = 8
# Define matrices P and C
P = np.array([[2, 3], [2, 5]])
C = np.array([[4, 5], [0, 7]])

# Initialize the matrix K
K = np.array([[1, 1], [-2, -7]])

gcd_count = 0
eq_c = 0
total_number = 0
range_m = range(modulus)
final_set = {}
for i in range_m:
    for j in range_m:
        for k in range_m:
            for l in range_m:
                total_number += 1
                # Update K with new values
                K = np.array([[i, j], [k, l]])
                # Calculate the determinant of K
                detK = int(np.linalg.det(K)) % 8
                # Check if the gcd of det(K) and modulus is 1
                gcd_mod_det = gcd(detK, modulus)
                if gcd_mod_det == 1:
                    gcd_count += 1
                    result = np.dot(P, K) % modulus
                    K = np.array([[i, j], [k, l]])
                    if np.array_equal(result, C):
                        eq_c += 1
                        print("K matrix:")
                        print(K[0])
                        print(K[1])
                        print(f"det(K): {detK}")
                        print(f"gcd_mod_det: {gcd_mod_det}")
                        # Calculate the result of P*K
                        print("The result of P*K which is equal to the C we expect to get:")
                        print(result[0])
                        print(result[1])
                        final_set[eq_c] = K

print(f"The total number of possible matrices is: {total_number}")
print(f"the final invertible count is           : {gcd_count}")
print(f"the # of final C being correct is       : {eq_c}")

print(f"number possible should be 8^4: {8**4}")
print(f"Therefore, the total number of invertible matrices that can \nproduce C is: {eq_c}")
print(f"percentage of solutions vs total number: {eq_c/total_number*100:.3f} %")
