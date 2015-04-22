def factors(num)
  results = []
  (1..num).each do |factor_candidate|
    if num % factor_candidate == 0
      results << factor_candidate
    end
  end

  results
end

def bubble_sort(arr)
  any_switched = true
  while any_switched do
    any_switched = single_bubble!(arr)
  end

  arr
end

def single_bubble!(arr)
  any_switched = false
  arr.each_index do |i|
    j = i + 1
    first = arr[i]
    second = arr[j]
    if second && first > second
      arr[i], arr[j] = arr[j], arr[i]
      any_switched = true
    end
  end

  any_switched
end

def substring(string)
  results = []
  (0...string.length).each do |starting_idx|
    max_substring_length = string.length - starting_idx
    (0...max_substring_length).each do |length|
      results << string.slice(starting_idx, length + 1)
    end
  end

  results
end

def subwords(string)
  dictionary = File.readlines("dictionary.txt")
  dictionary.map! { |word| word.chomp }
  results = substring(string)
  results.select! { |subword| dictionary.include? subword }

  results
end
