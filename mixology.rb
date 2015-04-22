def remix(ingredients)
  results = []
  alcohol = ingredients.map { |drink| drink[0] }
  mixers = ingredients.map { |drink| drink[1] }
  alcohol.each do |drink|
    mixer = mixers[rand(mixers.length)]
    results << [drink, mixer]
    mixers.delete(mixer)
  end
  results
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
