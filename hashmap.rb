class HashMap
  attr_reader :load_factor, :capacity

  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @capacity
  end

  def set(key, value)
    index = hash(key)
    bucket = @buckets[index]

    existing_pair = bucket.find { |pair| pair[0] == key }
    if existing_pair
      existing_pair[1] = value
    else
      bucket << [key, value]
      resize if load_factor_exceeded?
    end
  end

  def load_factor_exceeded?
    length.to_f / @capacity > @load_factor
  end

  def get(key)
    index = hash(key)
    bucket = @buckets[index]
    pair = bucket.find { |pair| pair[0] == key }
    pair ? pair[1] : nil
  end

  def has?(key)
    index = hash(key)
    bucket = @buckets[index]
    bucket.any? { |pair| pair[0] == key }
  end

  def length
    @buckets.sum { |bucket| bucket.length }
  end

  def remove(key)
    index = hash(key)
    bucket = @buckets[index]
    bucket.reject! { |pair| pair[0] == key }
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
  end

  def values
    @buckets.flat_map { |bucket| bucket.map { |pair| pair[1] } }
  end

  def keys
    @buckets.flat_map { |bucket| bucket.map { |pair| pair[0] } }
  end

  def entries
    @buckets.flat_map { |bucket| bucket }
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    p old_buckets

    old_buckets.each do |bucket|
      bucket.each do |key, value|
        set(key, value)
      end
    end
  end

  def dump
    @buckets.each_with_index do |bucket, index|
      bucket.each do |key, value|
        p "Bucket #{index}: #{key} => #{value}"
      end
    end
  end
end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('monkey', 'silver')
test.set('notebook', 'cyan')
test.dump
p test.length
test.set('apple', 'green')
puts test.get('apple')
p test.length
p test.has?('banana')
test.remove('banana')
p test.has?('banana')
p test.length
test.clear
p test.length
test.dump
