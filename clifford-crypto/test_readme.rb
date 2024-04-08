require './boot'
puts "importing boot"
puts " Creating a multivector"
m = Clifford::Multivector3D.new([2,3,4,5,6,7,8,9])
puts m.to_s

puts " Clifford conjugation"
puts m.clifford_conjugation.to_s
puts " or"
puts m.cc.to_s

puts " Reverse"
puts m.reverse.to_s

puts " Amplitude squared"
puts m.amplitude_squared.to_s

puts " Rationalize"
puts m.rationalize.to_s

puts " Inverse"
puts m.inverse.to_s

puts " Geometric product"
puts m.geometric_product(m.inverse).to_s
puts " or"
puts m.gp(m.inverse).to_s

puts m.gp(m).to_s

puts " Addition"
puts m.plus(m).to_s

puts " Subtraction"
puts m.minus(m).to_s

puts " Scalar division"
puts m.scalar_div(2).to_s

puts " Scalar multiplication"
puts m.scalar_mul(2).to_s

puts " Decomposition"
puts m.z.to_s
puts m.f.to_s

puts " F squared"
puts m.f2.to_s

puts " Eigenvalues"
puts m.eigenvalues.to_s

puts " Working with multivectors and modular arithmetic"
m_mod = Clifford::Multivector3DMod.new([2,3,4,5,6,7,8,9], 257)
puts m_mod.to_s

puts " Examples of operations with modulus"
puts m_mod.gp(m_mod).to_s
puts m_mod.scalar_div(2).to_s
puts m_mod.inverse.to_s

puts " Tools"
bits = 16
random_number = Clifford::Tools.random_number(bits)
puts random_number

random_prime = Clifford::Tools.random_prime(bits)
puts random_prime

next_prime = Clifford::Tools.next_prime(19222)
puts next_prime

n = 34985
b = 8
multivector_number = Clifford::Tools.number_to_multivector(n,b)
puts multivector_number.to_s

n_large = 18169120281480229197
multivector_large = Clifford::Tools.number_to_multivector(n_large,b)
multivector_to_number = Clifford::Tools.multivector_to_number(multivector_large,b)
puts multivector_to_number

puts " Number to multivector with modulus"
puts "b_mod:"
puts b_mod = 16
puts "q:"
puts q = Clifford::Tools.next_prime(2**b_mod)
puts "n_mod:"
puts n_mod = 155255861474355364696744344743093116292
puts "multivector mod (n_mod,b_mod,q)"
multivector_mod = Clifford::Tools.number_to_multivector_mod(n_mod,b_mod,q)
puts multivector_mod.to_s

puts " String to multivector"
s = "Clifford"
multivector_string = Clifford::Tools.string_to_multivector(s,b_mod)
puts multivector_string.to_s

puts " String to multivector with modulus"
s_large = "Clifford geometric algebra"
multivector_string_mod = Clifford::Tools.string_to_multivector_mod(s_large,b_mod,q)
puts multivector_string_mod.to_s

puts " Random multivector"
random_multivector = Clifford::Tools.generate_random_multivector(b_mod)
puts random_multivector.to_s

puts " Random multivector with modulus"
random_multivector_mod = Clifford::Tools.generate_random_multivector_mod(b_mod,q)
puts random_multivector_mod.to_s

puts " Random non-invertible multivector with modulus"
random_ni_multivector_mod = Clifford::Tools.generate_random_multivector_mod_ni(b_mod,q)
puts random_ni_multivector_mod.to_s

puts " Number to random multivector with modulus"
random_number_mod_multivector = Clifford::Tools.number_to_random_multivector_mod(n_mod,b_mod,q)
puts random_number_mod_multivector.to_s

l = 256

puts "party 1 and party 2 creation"
puts party1 = Clifford::Party.new(l,1)
puts party2 = Clifford::Party.new(l,2)

puts "setting the identifier for each party"
puts party1.set_public_communication_identifier(party2.pu)
puts party2.set_public_communication_identifier(party1.pu)

puts "generating the key"
puts party1.generate_sub_key
puts party2.generate_sub_key

puts "key exchange:"
puts party1.exchange(party2.s)
puts party2.exchange(party1.s)

puts "both share same key:"
puts party1.k
puts party2.k

puts "starting the server"
puts server = Clifford::EdgeServer.new(l)
puts "setting the device"
puts device = Clifford::EdgeDevice.new(l)

pu_1,s_1 = server.initiate_request(device.party.pu)
puts "pu_1:"
puts pu_1

pu_2,s_2 = device.exchange(pu_1,s_1)
puts server.register(pu_2,s_2)

puts "pu_2"
puts pu_2

puts "c: server.request_data:"
puts c = server.request_data(pu_2,3)

puts "d: device.recieve_data:"
puts d = device.receive_data(c)

puts "server data[3]"
puts server.data[3]



s = "Clifford geometric algebra"



Clifford::Hash.new(256,s)
puts "letter to encrypt:"
puts m_10 = "t"

# Convert each character to its ASCII value, format it as a string, then concatenate
ascii_str = m_10.chars.map { |char| char.ord.to_s }.join

# Convert the concatenated string to a number
m_10 = ascii_str.to_i
puts "ascii number corresponding to letter:"
puts m_10



test_str = "a"
puts "Original string:"
puts test_str

puts "\nConvert each character to its ASCII value, format it as a string with leading zeros, then concatenate:"
# Ensure each ASCII code is three digits by padding with zeros if necessary
ascii_str = test_str.chars.map { |char| format('%03d', char.ord) }.join

puts ascii_str


puts "Convert the concatenated string to a number"
puts m_10 = ascii_str.to_i
puts "ascii number corresponding to letter:"
puts m_10

puts ascii_number = m_10

crypto = Clifford::Crypto.new l

puts c = crypto.encrypt(m_10)
puts "encrypted"

puts "decrypting now:"
puts value = crypto.decrypt(c)
# Convert the number to a string
ascii_str = value.to_s.rjust(3,'0')



# Assuming ascii_str is a string where each ASCII code is represented as three digits
puts "\nConvert back to string:"

# Split the string into chunks of three characters each
chunks = ascii_str.scan(/.{3}/)  # Use .scan with a regex to split into chunks of three

# Convert each chunk from ASCII code to character, then join them into a string
original_str = chunks.map { |chunk| chunk.to_i.chr(Encoding::UTF_8) }.join

puts original_str
