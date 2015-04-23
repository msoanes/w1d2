#create a set class MyHashSet


class MyHashSet
  attr_reader :store

  def initialize(arr = [])
    @store = Hash.new
    arr.each do |el|
      self.insert(el)
    end
  end

  def include?(el)
    store[el] == true
  end


  def insert(el)
      store[el] = true
  end

  def delete(el)
    if self.include?(el)
      store.delete(el)
      true
    else
      false
    end
  end

  # intersect ->
  def intersect(other)
    result = MyHashSet.new
    store.each_key do |el|
      if other.include?(el)
        result.insert(el)
      end
    end
    result
  end

  # union
  def union(other)
    result = MyHashSet.new
    other.store.each_key do |el|
      result.insert(el)
    end
    store.each_key do |el|
      result.insert(el)
    end
    result
  end

  # minus
  def minus(other)
    result = MyHashSet.new
    store.each_key do |el|
      unless other.include?(el)
        result.insert(el)
      end
    end
    result
  end
end

# set1 = MyHashSet.new([1, 2, 3])
# set2 = MyHashSet.new([3, 4, 5])
# p set1.minus(set2)

tset = MyHashSet.new
p tset.include?(:test)
p tset.insert(:test)
p tset.include?(:test)
p tset.delete(:test)
p tset.include?(:test)
p tset.delete(:test)
