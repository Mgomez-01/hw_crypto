from sympy.ntheory import totient

# Calculate q^k - 1 for q = 37 and k = 4
q_k_minus_1 = 37**4 - 1
q_k = 37**4

# Calculate Euler's totient function
phi_value_min_1 = totient(q_k_minus_1)
phi_value = totient(q_k)

# Number of primitive polynomials
num_primitive_polynomials_min1 = phi_value_min_1 // 4
num_primitive_polynomials = phi_value // 4


print(f"using q^k - 1 :{q_k_minus_1}")
print(f"The number of primitive polynomials of degree 4 over F_37 is:{num_primitive_polynomials_min1}")
print(f"The total number of polynomials is:{q_k_minus_1}")
print(f"Their ratio is: {num_primitive_polynomials_min1/q_k_minus_1:.4f}")
print(f"or: {num_primitive_polynomials_min1/q_k_minus_1*100:.2f}%")

print(f"using q^k:{q_k}")
print(f"The number of primitive polynomials of degree 4 over F_37 is:{num_primitive_polynomials}")
print(f"The total number of polynomials is:{q_k}")
print(f"Their ratio is: {num_primitive_polynomials/q_k:.4f}")
print(f"or: {num_primitive_polynomials/q_k*100:.2f}%")
