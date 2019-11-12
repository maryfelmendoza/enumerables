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
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all?(val = nil)
    all_true = true

    if block_given?

      my_each do |element|
        all_true = false unless yield(element)
      end

    elsif val

      my_each do |element|
        all_true = false unless element == val
      end

    else

      my_each do |element|
        all_true = false unless element
      end

    end

    all_true
  end

  def my_any?(val = nil)

    any = false

    if block_given?
        my_each do |element|
            any = true if yield(element)
        end

    elsif val
      my_each do |element|
        any = true if element == val
      end

    else

      my_each do |element|
        any = true if element
      end

    end

    any
  end

  def my_none?(val = nil)

    none = true

    if block_given?

        my_each do |element|

            none = false if yield(element)

        end

    elsif val

        my_each do |element|

            none = false if element == val

        end

    else

        my_each do |element|

            none = false if element

        end

    end

    none
  end

  def my_count
    my_select { |x| yield(x) }.size
  end

  def my_map(&proc)
    return to_enum(:my_map) unless block_given?
    arr = []
    my_each { |i| arr << proc.call(i) }
    arr
  end

  def my_inject
    memo = 0
    my_each { |i| memo = yield(memo, i) }
    memo
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end

