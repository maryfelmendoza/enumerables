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

  def my_all?(pattern = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif pattern
      my_each do |i|
        return false unless pattern_match?(i, pattern)
      end
    else
      my_each { |i| return false unless i }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif pattern
      my_each do |i|
        return true if pattern_match?(i, pattern)
      end
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif pattern
      my_each do |i|
        return false if pattern_match?(i, pattern)
      end
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count
    my_select { |x| yield(x) }.size
  end

  def my_map(&proc)
    arr = []
    my_each { |i| arr << proc.call(i) }
    arr
  end

  def my_inject
    memo = 0
    my_each { |i| memo = yield(memo, i) }
    memo
  end

  def multiply_els(arr)
    arr.my_inject { |x, y| x * y }
  end
end
