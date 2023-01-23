require "byebug"

class Array
  def my_each(&blk)
    i = 0
    while i < self.length
      blk.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&block)
    res = []
    self.my_each { |el| res << el if block.call(el) }
    res
  end

  def my_reject(&block)
    res = []
    self.my_each { |el| res << el if !block.call(el) }
    res
  end

  def my_any?(&blk)
    res = self.my_select(&blk)
    res.length >= 1 ? true : false
  end

  def my_all?(&blk)
    res = self.my_select(&blk)
    res.length == self.length
  end
end

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
# 2
# 3
# 1
# 2
# 3

# p return_value  # => [1, 2, 3]
