def q_ary_lfsr(seed, taps, constants, q, length):
    """
    A function to simulate a q-ary LFSR.
    
    :param seed: Initial state of the LFSR (list of integers)
    :param taps: Positions that affect the feedback (list of integers)
    :param constants: Multiplicative constants for each tap (list of integers)
    :param q: Base of the LFSR (integer)
    :param length: Length of the sequence to generate
    :return: Generated LFSR sequence (list of integers)
    """
    # Initialize the register with the seed
    register = seed[:]
    output = []

    # Generate the sequence
    for _ in range(length):
        # Calculate the feedback bit as generalized XOR (mod-q addition) of the tapped positions
        feedback = sum(register[taps[i]] * constants[i] for i in range(len(taps))) % q
        # Output the bit at the last position
        output.append(register[-1])
        # Shift all bits, and place the feedback bit at the front
        register = [feedback] + register[:-1]

    return output

# Example usage for q = 2, similar to the binary LFSR example above
q = 2
seed = [0, 1, 0, 0]
taps = [0, 3]
constants = [1, 1]  # Since q = 2, the constants are still 1 (like binary feedback)
sequence_q2 = q_ary_lfsr(seed, taps, constants, q, 15)
print("Generated q-ary LFSR sequence for q=2 :", sequence_q2)

# Now test for q = 37 with the same configuration but different constants
q = 37
constants = [1, 1]  # Example constants for demonstration
sequence_q37 = q_ary_lfsr(seed, taps, constants, q, 15)
print("Generated q-ary LFSR sequence for q=37:", sequence_q37)
