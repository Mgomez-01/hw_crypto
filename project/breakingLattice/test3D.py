import numpy as np
# Redefine p_vector as a NumPy array for compatibility in calculations
p_vector_array = np.array([3.1, 1.24, 2.3])
print("correct point: [3 1 2]")
print(f"bad point    : {p_vector_array}")

# Define a tolerance for the distance to the plane
tolerance = 0.5  # Distance units

# Define a confined search range around p
search_radius = 2  # Search within a cube of edge length 2 centered around each component of p

# Search for closest lattice point with tolerance to the plane
closest_point_3d_tol = None
min_distance_3d_tol = float('inf')

# Function to calculate the distance from a point to a plane given by Ax + By + Cz + D = 0
def distance_to_plane(point, normal_vector):
    x, y, z = point
    A, B, C = normal_vector
    D = 0  # Since the plane passes through the origin
    # Distance formula |Ax + By + Cz + D| / sqrt(A^2 + B^2 + C^2) for plane Ax + By + Cz + D = 0
    return abs(A*x + B*y + C*z + D) / np.sqrt(A**2 + B**2 + C**2)


# Redefine the normal vector in array format for calculations
normal_vector_array = np.array([0, 2, -1.5])


# Narrow the search range based on the radius around p
for x in range(int(p_vector_array[0]) - search_radius, int(p_vector_array[0]) + search_radius + 1):
    for y in range(int(p_vector_array[1]) - search_radius, int(p_vector_array[1]) + search_radius + 1):
        for z in range(int(p_vector_array[2]) - search_radius, int(p_vector_array[2]) + search_radius + 1):
            lattice_point = np.array([x, y, z])
            plane_distance = distance_to_plane(lattice_point, normal_vector_array)
            # Check if the point is within the tolerance distance to the plane
            if plane_distance <= tolerance:
                dist = np.linalg.norm(lattice_point - p_vector_array)
                if dist < min_distance_3d_tol:
                    min_distance_3d_tol = dist
                    closest_point_3d_tol = lattice_point

print(f"closest_point: {closest_point_3d_tol}\nmin distance:{min_distance_3d_tol}")
