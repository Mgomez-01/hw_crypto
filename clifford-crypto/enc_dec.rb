require './boot.rb'

# Assuming l is defined elsewhere or passed as an argument
def encrypt(crypto, char, l)
 # Convert character to its ASCII value, formatted as a string with leading zeros
  ascii_str = format('%03d', char.ord)
  # Convert the ASCII string to a number
  m_10 = ascii_str.to_i
  # Initialize Clifford Crypto with a given lambda (l)
  # Encrypt the number
  encrypted = crypto.encrypt(m_10)
  #puts "\nEncrypted value: " + encrypted.to_s
  return encrypted
end

def decrypt(crypto, encrypted, l)
    # Decrypt the value
  decrypted = crypto.decrypt(encrypted)
  # Convert the decrypted number back to ASCII string, ensuring it's padded if necessary
  ascii_str = decrypted.to_s.rjust(3, '0')
  # Convert back to string
  original_char = ascii_str.to_i.chr(Encoding::UTF_8)
  return original_char

end


def parse_multivector(line)
  # Extract the coefficients from the string
  pattern = /(-?\d+(?:\.\d+)?)(?=e\d+)/
  coeffs = line.scan(pattern).flatten.map(&:to_i)
  
  # Validate we have the right number of components (8 for Multivector3D)
  raise ArgumentError, "Invalid multivector format" unless coeffs.size == 8
  
  Clifford::Multivector3D.new(coeffs)
end



# Example usage
l = 128 # Example lambda value, adjust as necessary for your Clifford::Crypto setup
crypto = Clifford::Crypto.new(l)

# Initialize an empty string
ascii_string = ""

# Loop over the range of ASCII characters
(0..127).each do |code_point|
  # Convert the code point to a character and append it to the string
  ascii_string << code_point.chr
end





puts "string of all ascii: \n" + ascii_string

if ARGV.empty?
  puts "Usage: ruby #{__FILE__} <filename in> <filename out>"
  exit 1
end

# The first argument is assumed to be the filename
filename_in = ARGV[0]
filename_out = ARGV[1]

file_out = File.open(filename_out, "w")

file_in = File.open(filename_in, "r")

file_in.each_line do |line|
  ascii_string = ascii_string + line
end
file_in.close



ascii_string.each_char do |char|

  encrypted = encrypt(crypto, char, l)  # And `decrypt_char` is your decryption method
  file_out.puts(encrypted)
  decrypted = decrypt(crypto, encrypted, l)  # And `decrypt_char` is your decryption method  
  #puts "current char: |" + char + "|  decrypted: |" + decrypted + "|"
  
  if decrypted != char
    puts "Mismatch for character #{char.inspect}: got #{decrypted.inspect}"
  end
end

puts "All ASCII characters tested.\n\nAll passed."
file_out.close






puts "Reading file...\n\n"

file = File.open(filename_out, "r")
result = ""
file.each_line do |line|
  decrypted = decrypt(crypto, parse_multivector(line.strip), l)  # And `decrypt_char` is your decryption method  
  #puts "decrypted: |" + decrypted + "|"
  result = result + decrypted
end

file.close

puts "resulting decrypted string: \n\n" + result
