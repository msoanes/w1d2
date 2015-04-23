class Array
  def my_uniq
    result = Array.new
    self.each do |e|
      if result.include? e
        next
      else
        result << e
      end
    end
    result
  end

  def two_sum
    result = Array.new
    self.each_index do |idx|
      ((idx + 1)...self.length).each do |jdx|
        if self[idx] + self[jdx] == 0
          result << [idx, jdx]
        end
      end
    end
    result
  end
end

def my_transpose(arr)
  result = Array.new
  (0...arr.length).each do |i|
    (0...arr.length).each do |j|
      if result.length <= j
        result << Array.new
      end
      result[j][i] = arr[i][j]
      p result
    end
  end
  result
end

def pick(arr)
  first = nil
  last = nil
  diff = 0
  arr.each_index do |i|
    ((i + 1)...arr.length).each do |j|
      c_diff = arr[j] - arr[i]
      if c_diff > diff
        first = i
        last = j
        diff = c_diff
      end
    end
  end
  [first, last]
end



# p pick([1,3,5,2,6,9,0,4])

# test_arr = [1,2,3,4,4,5,6,6]
# p test_arr.my_uniq
# p [-1, 0, 2, -2, 1].two_sum #== [[0, 4], [2, 3]]

# p my_transpose([
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ])
 # => [[0, 3, 6],
 #    [1, 4, 7],
 #    [2, 5, 8]]
