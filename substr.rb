# frozen_string_literal: true

def substrings(word, dict)
  result = Hash.new(0)
  dict.each do |sub|
    result[sub] += 1 if word.include?(sub)
  end
  result
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
puts substrings('below', dictionary)
