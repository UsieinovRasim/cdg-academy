def foobar(attr1, attr2)
  a = attr1.to_f
  b = attr2.to_f

  a == 20 || b == 20 ? b : a + b
end

puts foobar(20, 325)
