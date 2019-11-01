# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self.class == Array ? self : to_a
    i = 0
    while i < size
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return(:my_select) unless block_given?

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
    my_each { |i| yield i && total += 1 }
    total
  end

  def my_map(&block)
    return to_enum(:my_map) unless block_given?

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
