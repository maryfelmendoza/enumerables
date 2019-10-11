# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_select
    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all?
    my_each { |i| return false unless yield(i) }
    true
  end

  def my_any?
    my_each { |i| return true if yield(i) }
    false
  end

  def my_none?
    my_each { |i| return false if yield(i) }
    true
  end

  def my_count
    total = 0
    my_each { |i| if yield i then total += 1 end }
    total
  end

  def my_map(&block)
    arr = []
    my_each { |i| result.push(block.call(i)) }
    arr
  end

  def my_inject
    memo = self[0]
    my_each { |i| memo = yield(memo, i) }
    memo
  end

  def multiply_els
    arr.my_inject { |x, y| x * y }
  end
end
