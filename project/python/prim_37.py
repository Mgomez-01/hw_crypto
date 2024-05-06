import galois

prim_enum = enumerate(galois.primitive_polys(37,3,3))

polys = []
for i,j in prim_enum:
    print(f"minpoly = {j}; f^2;")
    polys.append(j)

print(polys)
