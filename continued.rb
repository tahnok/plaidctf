require 'openssl'

def euclid(a,b)
  if b > a
    return euclid(b,a)
  else
    target = a
    divisor = b
    remainder = 1
    while remainder != 0
      puts target, divisor
      _, remainder = target.divmod(divisor)
      divisor,target = remainder,divisor
    end
    return target
  end
end

def continued(a,b)
  if b > a
    return [0] + continued(b,a)
  else
    components = []
    target = a
    divisor = b
    remainder = 1
    while remainder != 0
      component, remainder = target.divmod(divisor)
      components << component
      divisor,target = remainder,divisor
    end
    return components
  end
end

def continued_to_convergent(continued_list)
  list = continued_list.clone
  base = Rational(list.pop,1)
  return list.reverse.inject(base) do |fraction,num|
    num + 1/(fraction)
  end
end

def get_convergents(e,n)
  continued_list = continued(e,n)
  convergents = (1..continued_list.size).map do |length|
    continued_list.first(length)
  end.map do |list|
    continued_to_convergent(list)
  end
end

def get_possible_keys(e,n)
  max_key = (n**(1.0/4))/3
  get_convergents(e,n).map do |c|
    c.denominator
  end.select do |key|
    key < max_key
  end
end

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

messages.each_with_index do |message,i|
  $stderr.puts "trying #{i}"
  n = message[:n]
  e = message[:e]
  c = message[:c]

  possible_keys = get_possible_keys(e,n)
  possible_keys.map do |key|
    [c.to_bn.mod_exp(key,n).to_s(16)].pack("H*")
  end.select do |plaintext|
    !(plaintext =~ /[^[:print:]]/)
  end.each do |text|
    puts text
  end
end

