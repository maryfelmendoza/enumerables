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

  def my_all?(arg = nil)
    resp = true
    return true if to_a.nil? || (self.class.to_s == 'Hash' && !block_given?)

    if block_given?
      to_a.my_each { |val| resp = false unless yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| resp = false unless val }
    else
      case arg.class.to_s
      when 'Regexp'
        to_a.my_each { |val| resp = false unless arg.match? val.to_s }
      when 'Class'
        to_a.my_each { |val| resp = false unless val.is_a? arg }
      else
        to_a.my_each { |val| return resp = false unless val == arg }
      end
    end
    resp
  end

  def my_any?(arg = nil)
    resp = false
    return false if to_a.nil?
    return true  if self.class.to_s == 'Hash' && !block_given?

    if block_given?
      to_a.my_each { |val| resp = true if yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| resp = true if val }
    else
      case arg.class.to_s
      when 'Regexp'
        puts 'regex'
        to_a.my_each { |val| resp = true if arg.match? val.to_s }
      when 'Class'
        puts 'class'
        to_a.my_each { |val| resp = true if val.is_a? arg }
      else
        puts 'else'
        to_a.my_each { |val| return resp = true if val == arg }
      end
    end
    resp
  end

  def my_none?(arg = nil)
    resp = true
    return true if to_a.nil?
    return false if self.class.to_s == 'Hash' && !block_given?

    if block_given?
      to_a.my_each { |val| resp = false if yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| resp = false if val }
    else
      case arg.class.to_s
      when 'Regexp'
        to_a.my_each { |val| resp = false if arg.match? val.to_s }
      when 'Class'
        to_a.my_each { |val| resp = false if val.is_a? arg }
      else
        to_a.my_each { |val| return resp = false if val == arg }
      end
    end
    resp
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
