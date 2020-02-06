module Enumerable
  def my_each
    if block_given?
      array = self
      0.upto(array.length - 1) do |i|
        yield(array[i])
      end
      array
    else
      array.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      array = self
      0.upto(array.length - 1) do |i|
        yield(array[i], i)
      end
    else
      array.to_enum
    end
  end

  def my_select
    if block_given?
      array = self
      total = []
      0.upto(array.length - 1) do |i|
        total << array[i] if yield(array[i])
      end
      total
    else
      array.to_enum
    end
  end

  def my_all?(arg = nil)
    result = true
    return true if to_a.nil? || (self.class.to_s == 'Hash' && !block_given?)

    if block_given?
      to_a.my_each { |val| result = false unless yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| result = false unless val }
    else
      case arg.class.to_s
      when 'Regexp'
        to_a.my_each { |val| result = false unless arg.match? val.to_s }
      when 'Class'
        to_a.my_each { |val| result = false unless val.is_a? arg }
      else
        to_a.my_each { |val| return result = false unless val == arg }
      end
    end
    result
  end

  def my_any?(arg = nil)
    result = false
    return false if to_a.nil?
    return true if self.class.to_s == 'Hash' && !block_given?

    if block_given?
      to_a.my_each { |val| result = true if yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| result = true if val }
    else
      case arg.class.to_s
      when 'Regexp'
        puts 'regex'
        to_a.my_each { |val| result = true if arg.match? val.to_s }
      when 'Class'
        puts 'class'
        to_a.my_each { |val| result = true if val.is_a? arg }
      else
        puts 'else'
        to_a.my_each { |val| return result = true if val == arg }
      end
    end
    result
  end

  def my_none?(arg = nil)
    result = true
    return true if to_a.nil?
    return false if self.class.to_s == 'Hash' && !block_given?

    if block_given?
      to_a.my_each { |val| result = false if yield(val) }
    elsif arg.nil?
      to_a.my_each { |val| result = false if val }
    else
      case arg.class.to_s
      when 'Regexp'
        to_a.my_each { |val| result = false if arg.match? val.to_s }
      when 'Class'
        to_a.my_each { |val| result = false if val.is_a? arg }
      else
        to_a.my_each { |val| return result = false if val == arg }
      end
    end
    result
  end

  def my_count(arg = nil)
    array = self
    return array.length unless block_given? || arg

    count = 0
    if arg
      array.my_each { |val| count += 1 if val == arg }
    else
      array.my_each { |val| count += 1 if yield(val) }
    end
    count
  end

  def my_map(a_proc = nil)
    array = self
    return to_enum(:my_map) unless block_given?

    if a_proc.nil?
      array.my_each_with_index { |v, i| array[i] = yield(v) }
    else
      array.my_each_with_index { |v, i| array[i] = a_proc.call(v) }
    end
    array
  end

  def my_inject(int = to_a[0], operator = :+)
    if int.is_a? Symbol
      operator = int
      int = to_a[0]
    end
    accumulator = int
    if block_given?
      to_a.my_each { |val| accumulator = yield(accumulator, val) }
    else
      to_a.my_each { |val| accumulator = accumulator.send(operator, val) }
    end
    accumulator
  end
end

def multiply_els(array)
  array.my_inject { |x, y| x * y }
end

puts multiply_els([2, 4, 5])
