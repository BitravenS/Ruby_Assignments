# frozen_string_literal: true

def merge(left, right)
  merged = []
  i = j = 0

  while i < left.length && j < right.length
    if left[i] <= right[j]
      merged << left[i]
      i += 1
    else
      merged << right[j]
      j += 1
    end
  end

  merged.concat(left[i..]) if i < left.length
  merged.concat(right[j..]) if j < right.length

  merged
end

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left_half = merge_sort(arr[0...mid])
  right_half = merge_sort(arr[mid..])

  merge(left_half, right_half)
end

test_array = [38, 27, 43, 3, 9, 82, 10]
puts merge_sort(test_array).inspect
