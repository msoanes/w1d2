def super_print(str, options = {})
  if options[:reverse]
    str.reverse!
  end
  if options[:upcase]
    str.upcase!
  end
  count = options[:times] || 1

  count.times do
    print str
  end
end
