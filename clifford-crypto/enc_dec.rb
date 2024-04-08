require './boot.rb'

# Assuming l is defined elsewhere or passed as an argument
def encrypt_and_decrypt_char(char, l)
 # Convert character to its ASCII value, formatted as a string with leading zeros
  ascii_str = format('%03d', char.ord)
  # Convert the ASCII string to a number
  m_10 = ascii_str.to_i
  # Initialize Clifford Crypto with a given lambda (l)
  crypto = Clifford::Crypto.new(l)
  # Encrypt the number
  encrypted = crypto.encrypt(m_10)
  puts "\nEncrypted value:"
  puts encrypted
  # Decrypt the value
  decrypted = crypto.decrypt(encrypted)
  # Convert the decrypted number back to ASCII string, ensuring it's padded if necessary
  ascii_str = decrypted.to_s.rjust(3, '0')
  # Convert back to string
  original_char = ascii_str.to_i.chr(Encoding::UTF_8)
  return original_char
end

# Example usage
l = 128 # Example lambda value, adjust as necessary for your Clifford::Crypto setup

message = "
This is a message I am encrypting.
This will be passed through the encrypter one char at a time.
Then after passing through encryption, it will be decrypted and
rebuilt.
"
built_message = ""
puts message
message.each_char do |char|
  built_message = built_message + encrypt_and_decrypt_char(char, l)
end

puts "rebuilt decrypted text:"
puts built_message
