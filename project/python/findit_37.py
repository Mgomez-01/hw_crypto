import galois
from rich import print
encode = {k:i for i,k in enumerate("0123456789abcdefghijklmnopqrstuvwxyz ")}

def findit_37(s):
    GF = galois.GF(37**4, irreducible_poly="x^4+ x + 2")
    text = [ord(i) for i in s]
    y = GF(text)
    return galois.berlekamp_massey(y, output="galois")

def findit_ascii(s):
    GF = galois.GF(2)
    text = [c for g in s for c in bin(ord(g))[2:] ]
    y = GF(text)
    return galois.berlekamp_massey(y, output="galois")


print(findit_37("hello world from miguel and ashton to priyank"))
print(findit_ascii("hello world!"))
print(findit_ascii("hello world! from miguel and ashton to priyank"))

print(findit_37("The format() function simply formats the input following the Format Specification mini language. The # makes the format include the 0b prefix, and the 010 size formats the output to fit in 10 characters width, with 0 padding; 2 characters for the 0b prefix, the other 8 for the binary digits."))
