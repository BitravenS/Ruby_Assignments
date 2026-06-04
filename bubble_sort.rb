# frozen_string_literal: true

def bubble_sort(list)
  loop do
    swapped = false
    (list.length - 1).times do |i|
      next unless list[i] > list[i + 1]

      list[i 1] = list[i]
      list[i] = list[i + 1]
      swapped = true
    end
    break unless swapped
  end
  list
end

puts bubble_sort([5, 3, 8, 4, 2])
