module Enumerable
  def my_each
    if block_given?
      arr = self
      0.upto(arr.length - 1) do |i|
        yield(arr[i])
      end
      arr
    else
      arr.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      arr = self
      0.upto(arr.length - 1) do |i|
        yield(arr[i], i)
      end
    else
      arr.to_enum
    end
  end

  def my_select
    if block_given?
      arr = self
      result = []
      0.upto(arr.length - 1) do |i|
        result << arr[i] if yield(arr[i])
      end
      result
    else
      arr.to_enum
    end
  end

  def my_all(val = nil)
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
      my_each do |x|
        any = true if yield(x)
      end

    elsif val
      my_each do |x|
        any = true if x == val
      end

    else

      my_each do |x|
        any = true if x
      end

    end

    any
  end

  def my_none?(val = nil)
    none = true

    if block_given?
      my_each do |x|
        none = false if yield(x)
      end

    elsif val

      my_each do |x|
        none = false if x == val
      end

    else

      my_each do |x|
        none = false if x
      end

    end

    none
  end

  def my_count(val = nil)
    total = 0

    if block_given?
      my_each do |x|
        total += 1 if yield(x)
      end

    elsif val

      my_each do |x|
        total += 1 if x == val
      end

    else

      total = length

    end

    total
  end

  def my_map(my_proc = nil)
    new_array = []

    if my_proc
      my_each do |x|
        new_array.push(my_proc.call(x))
      end

    else

      my_each do |x|
        new_array.push(yield(x))
      end
    end

    new_array
  end

  def my_inject(init = to_a[0], oper = :+)
    if init.is_a? Symbol
      oper = init
      init = to_a[0]
    end
    accum = init
    if block_given?
      to_a.my_each { |val| accum = yield(accum, val) }
    else
      to_a.my_each { |val| accum = accum.send(oper, val) }
    end
    accum
  end
end

def multiply_els(array)
  array.my_inject { |x, y| x * y }
end

puts multiply_els([2, 4, 5])
