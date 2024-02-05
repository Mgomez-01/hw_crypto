import numpy as np
from math import gcd
from rich import print

# Since Python doesn't have a built-in function to set cores directly like Singular, we'll skip those operations.
modulus = 8
# Define matrices P and C
P_attac = np.array([[2, 1], [7, 4]])
P = np.array([[2, 3], [2, 5]])

# Initialize the matrix K
K = np.array([[3, 1], [2, 1]])

P_inv = np.linalg.inv(P) % 8
P_inv_att = np.linalg.inv(P_attac) % 8

print(f"P: \n{P}")
print(f"K: \n{K}")
print(f"P_att_inv: \n{P_inv_att}")
C = np.dot(P, K) % 8
C_attac = np.dot(P_attac, K) % 8
print(f"C: \n{C}")
print(f"C_attac: \n{C_attac}")
print(f"P^-1*C = P^-1*P*K = K: \n{np.dot(C_attac, P_inv) % 8}")
