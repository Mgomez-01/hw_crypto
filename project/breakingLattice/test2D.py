import numpy as np


# Define the bad point in 2D
p_2d = np.array([2.5, 1.5])

# Parameters for the line
slope = p_2d[1] / p_2d[0]

print(f"correct point: [2 1]")
print(f"bad point    : {p_2d}")
print(f"slope with origin: {slope}")
# Function to calculate the distance from a point to a line given by y = mx
def distance_to_line(point, slope):
    x, y = point
    # Line equation y = mx -> mx - y = 0
    # Distance formula |Ax + By + C| / sqrt(A^2 + B^2) for line Ax + By + C = 0
    return abs(slope*x - y) / np.sqrt(slope**2 + 1)

# Search for closest lattice point within a range of -10 to 10 for both x and y
lattice_range = range(-10, 11)
closest_point = None
min_distance = float('inf')

# Iterate over lattice points and calculate distances
for n in lattice_range:
    for m in lattice_range:
        lattice_point = np.array([n, m])
        dist = np.linalg.norm(lattice_point - p_2d)
        if dist < min_distance:
            min_distance = dist
            closest_point = lattice_point

print(f"Best fit point given the bad point: {closest_point} \nmin_distance:{min_distance}")
