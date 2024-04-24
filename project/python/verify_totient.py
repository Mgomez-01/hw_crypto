from sympy import factorint, totient

# Calculate q^k - 1 for q = 37 and k = 4
q_k_minus_1 = 37**4 - 1

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

manual_phi = int(manual_phi)
print("Manually calculated phi:", manual_phi)
