def bubble_sort(list)
  loop do
    swapped = false
    (list.length-1).times do |i|
      if list[i] > list[i+1]
        list[i], list[i 1] = list[i+1], list[i]
        swapped = true
      end
    end
    if not swapped
      break
    end
  end
  list
end

puts bubble_sort([5, 3, 8, 4, 2])