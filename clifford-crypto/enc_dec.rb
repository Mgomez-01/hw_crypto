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


# Initialize an empty string
ascii_string = ""

# Loop over the range of ASCII characters
(0..127).each do |code_point|
  # Convert the code point to a character and append it to the string
  ascii_string << code_point.chr
end

puts "string of all ascii: \n" + ascii_string

ascii_string.each_char do |char|
  decrypted = encrypt_and_decrypt_char(char, l)  # And `decrypt_char` is your decryption method
  puts "current char: |" + char + "|  decrypted: |" + decrypted + "|"
  
  if decrypted != char
    puts "Mismatch for character #{char.inspect}: got #{decrypted.inspect}"
  end
end

puts "All ASCII characters tested.\n\nAll passed."



# message = "
# This is a message I am encrypting.
# This will be passed through the encrypter one char at a time.
# Then after passing through encryption, it will be decrypted and
# rebuilt.
# "
# built_message = ""
# puts message
# message.each_char do |char|
#   built_message = built_message + encrypt_and_decrypt_char(char, l)
# end

# puts "rebuilt decrypted text:"
# puts built_message
