# frozen_string_literal: true

module Enumerable # rubocop:disable Style/Documentation
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    my_each do |elem|
      yield(elem, index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |elem| result << elem if yield(elem) }
    result
  end

  def my_all?
    my_each { |elem| return false unless yield(elem) }
    true
  end

  def my_any?
    my_each { |elem| return true if yield(elem) }
    false
  end

  def my_none?
    my_each { |elem| return false if yield(elem) }
    true
  end

  def my_count
    return size unless block_given?

    count = 0
    my_each { |elem| count += 1 if yield(elem) }
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    my_each { |elem| result << yield(elem) }
    result
  end

  def my_inject(accumulator)
    my_each { |elem| accumulator = yield(accumulator, elem) }
    accumulator
  end
end

class Array # rubocop:disable Style/Documentation
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield self[i]
      i += 1
    end
    self
  end
end
