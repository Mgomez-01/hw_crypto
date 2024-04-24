import math

# Constants
p = 0.0627  # probability of winning
q = 1 - p  # probability of losing
desired_probability = 0.99  # 99% chance of winning at least once

# Calculate number of trials needed
n = math.log(1 - desired_probability) / math.log(q)
print(f"the number of trials needed to guarantee hitting would be {math.ceil(n)}")
