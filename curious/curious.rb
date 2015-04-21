require 'pry'

raw = File.read("captured_a4ff19205b4a6b0a221111296439b9c7").split("\n")
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

binding.pry
