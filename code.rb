

module Enumerable
  def my_each
    size = self.size
    index = 0

    while index < size

      yield(self[index])
      index += 1
    end
  end

  def my_each_with_index
    size = self.size
    index = 0

    while index < size

      yield(self[index], index)
      index += 1
    end
  end

  def my_select
    new_array = []

    my_each do |x|
      new_array.push(x) if yield(x)
    end

    new_array
  end

  def my_all?(val = nil)
    all_true = true

    if block_given?

      my_each do |x|
        all_true = false unless yield(x)
      end

    elsif val

      my_each do |x|
        all_true = false unless x == val
      end

    else

      my_each do |x|
        all_true = false unless x
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

  def my_inject(init = nil, proc = nil)
    if init && block_given?

      my_each do |x|
        init = yield(init, x)
      end

    elsif init.nil? && block_given?

      init = self[0]

      my_each_with_index do |x, index|
        init = yield(init, x) unless index.zero?
      end
    else

      my_each do |x|
        init = proc.to_proc.call(init, x)
      end
    end
    init
  end
end

def multiply_els(array)
  array.my_inject { |x, y| x * y }
end

puts multiply_els([2, 4, 5])
