import galois
encode = {k:i for i,k in enumerate("0123456789abcdefghijklmnopqrstuvwxyz ")}

def findit_37(s):
    GF = galois.GF(37)
    text = [encode[i] for i in s]
    y = GF(text)
    return galois.berlekamp_massey(y, output="galois")

def findit_ascii(s):
    GF = galois.GF(2)
    text = [c for g in s for c in format(ord(g), '07b')]
    y = GF(text)
    return galois.berlekamp_massey(y, output="galois")

def findit_ascii_parallel(s):
    GF = galois.GF(2)
    s = "hello world!"
    for i in range(0,7):
        text = [format(ord(g), '07b')[i] for g in s]
        y = GF(text)
        yield galois.berlekamp_massey(y, output="galois")

def findit_ascii_big(s):
    GF = galois.GF(2**7)
    s = "hello world!"
    text = [ord(g) for g in s]
    y = GF(text)
    return galois.berlekamp_massey(y, output="galois")

print(findit_37("hello world"))

# print(findit_37("hello world from miguel and ashton to priyank"))
# print(findit_ascii("hello world!"))
# print(findit_ascii_big("hello world! from miguel and ashton to priyank"))
