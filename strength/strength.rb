require 'openssl'

raw = File.read("captured_827a1815859149337d928a8a2c88f89f").split("\n")
raw = raw[1..raw.length] #drop {N, e, c}
 
messages = []
 
raw.each do |raw_line|
  temp = raw_line.split(/({| : |})/)
  messages << {
    n: temp[2].to_i(16),
    e: temp[4].to_i(16),
    c: temp[6].to_i(16)
  }
end
 
first = messages[8]
second = messages[18]
modulus = first[:n]

#figured these out by putting first[:e]*x + second[:e]*y = 1 into wolfram
x = 13351214972
y = -1396453719

plaintext = [first[:c].to_bn.mod_exp(x,modulus).mod_mul(
    # invert the second key because y is negative
    second[:c].to_bn.mod_inverse(modulus).mod_exp(y.abs,modulus), modulus).to_s(16)].pack("H*")
puts plaintext
