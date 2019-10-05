module Enumerable

  def my_each
    for i in 0...self.length
      yield (self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield (self[i],i)
    end
  end

  def my_select
    # your code here
    result = []
    self.my_each { |i| result.push(i) if yield(i)}
    result
  end

  def my_all?
    self.my_each {|i| return false unless yield(i)}
    true
  end

  def my_any?
    self.my_each {|i| return true if yield(i)} 
    false
  end

  def my_none?
    self.my_each {|i| return false if yield(i)} 
    true
  end

  def my_count
    total = 0
    self.my_each {|i| if (yield(i)) then total += 1 end}
    return total
  end

  def my_map(&block)
    arr = []
    self.my_each {|i| result.push(block.call(i))}
    return arr
  end

  def my_inject
    memo = self[0]
    self.my_each {|i| memo = yield(memo, i)}
    memo
  end

  def multiply_els
    arr.my_inject {|x,y| x*y}
  end

$end