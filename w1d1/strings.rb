#out own to_s
def num_to_s(num, base=10)
  numbers_to_strings = Hash.new
  (0..9).each do |i|
    numbers_to_strings[i] = i.to_s
  end

  (10..15).each do |i|
    numbers_to_strings[i] = ('A'..'Z').to_a[i - 10]
  end

  divisor = 1
  result = []

  loop do
    break if (num / divisor) == 0
    result.unshift( (num / divisor) % base)
    divisor *= base
  end
  result.map { |x| numbers_to_strings[x] }.join('')
end

p num_to_s(234, 16)

def caesar(str, offset)
  results = Array.new
  str.each_char do |letter|
    offset.times do
      if letter == 'z'
        letter = 'a'
      else
        letter = letter.next
      end
    end
    results << letter
  end
  results.join('')
end

p caesar("abcdefz", 5)
