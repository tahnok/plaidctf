require 'pry'

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
      puts target, divisor
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

binding.pry
