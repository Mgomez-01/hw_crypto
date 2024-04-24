from Crypto.Cipher import ChaCha20
from Crypto.Random import get_random_bytes

def encrypt_chacha20(plaintext, key):
    cipher = ChaCha20.new(key=key)
    ciphertext = cipher.encrypt(plaintext)
    return cipher.nonce, ciphertext

def decrypt_chacha20(ciphertext, key, nonce):
    cipher = ChaCha20.new(key=key, nonce=nonce)
    plaintext = cipher.decrypt(ciphertext)
    return plaintext

# Example usage
key = get_random_bytes(32)  # ChaCha20 uses a 256-bit key
plaintext = b"This was an example of the chacha!"

# Encrypting the plaintext
nonce, ciphertext = encrypt_chacha20(plaintext, key)
print("Ciphertext:", ciphertext.hex())

# Decrypting back to plaintext
decrypted_text = decrypt_chacha20(ciphertext, key, nonce)
print("Decrypted:", decrypted_text.decode())
