def double(arr)
  arr.map { |x| x * 2 }
end

class Array
  def my_each(&prc)
    0.upto(self.length - 1) do |i|
      prc.call(self[i])
    end
    self
  end
end

def median(carr)
  arr = carr.clone.sort
  if arr.length % 2 == 0
    upper_mid = arr.length / 2
    lower_mid = upper_mid - 1
    (arr[upper_mid] + arr[lower_mid]) / 2.0
  else
    mid = arr.length / 2
    arr[mid]
  end
end

def concatenate(arr)
  if arr.all? { |x| x.is_a?(String) }
    arr.inject(:+)
  end
end

p concatenate([0, "Yay ", "for ", "strings!"])

# p median([1, 2, 3, 4, 5, 6, 7, 8])
#
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
#
# p return_value
