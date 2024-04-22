import sys

# ----------------------------------------------------------------------------
# Crypto4o functions start here
# ----------------------------------------------------------------------------

class GLFSR:
    """Galois linear-feedback shift register."""

    def __init__(self, polynom, initial_value):
        print(f"Using polynom 0x{polynom:X}, initial value: 0x{initial_value:X}.")

        self.polynom = polynom | 1
        self.data = initial_value
        tmp = polynom
        self.mask = 1

        while tmp != 0:
            if tmp & self.mask:
                tmp ^= self.mask

            if tmp == 0:
                break

            self.mask <<= 1

    def next_state(self):
        self.data <<= 1

        retval = 0

        if self.data & self.mask:
            retval = 1
            self.data ^= self.polynom

        return retval

class SPRNG:
    def __init__(self, polynom_d, init_value_d, polynom_c, init_value_c):
        print("GLFSR D0: ", end="")
        self.glfsr_d = GLFSR(polynom_d, init_value_d)
        print("GLFSR C0: ", end="")
        self.glfsr_c = GLFSR(polynom_c, init_value_c)

    def next_byte(self):
        byte = 0
        bitpos = 7

        while bitpos >= 0:
            bit_d = self.glfsr_d.next_state()
            bit_c = self.glfsr_c.next_state()

            if bit_c:
                bit_r = bit_d
                byte |= bit_r << bitpos

            bitpos -= 1

        return byte

# ----------------------------------------------------------------------------
# Crypto4o functions end here
# ----------------------------------------------------------------------------

def main():
    # Example of initializing the pseudo-random number generator
    polynom_d = 0x1002D  # 16-bit polynomial
    init_value_d = 0x1    # Non-zero initial value

    polynom_c = 0x80200003  # 32-bit polynomial
    init_value_c = 0x2      # Non-zero initial value

    prng = SPRNG(polynom_d, init_value_d, polynom_c, init_value_c)

    with open(sys.argv[1], "rb") as f, open(sys.argv[2], "wb") as g:
        while True:
            input_ch = f.read(1)

            if not input_ch:
                break

            random_ch = prng.next_byte() & 0xFF
            g.write(bytes([input_ch[0] ^ random_ch]))

if __name__ == "__main__":
    main()
