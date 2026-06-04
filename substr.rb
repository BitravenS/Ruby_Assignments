def substrings(word, dict)
  result = Hash.new(0)
  dict.each do |sub|
    if word.include?(sub)
      result[sub] += 1
    end
  end
  result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
