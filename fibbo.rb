def fibs(n)
  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2

  fib_sequence = [0, 1]
  (3..n).each do
    next_fib = fib_sequence[-1] + fib_sequence[-2]
    fib_sequence << next_fib
  end

  fib_sequence
end

def fibs_rec(n, sequence = [0, 1])
  return [] if n <= 0
  return [0] if n == 1
  return sequence if n <= 2

  next_fib = sequence[-1] + sequence[-2]
  fibs_rec(n - 1, sequence << next_fib)
end

puts "Iterative: #{fibs(10)}"
puts "Recursive: #{fibs_rec(10)}"
