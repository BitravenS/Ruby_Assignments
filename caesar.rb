
def rotate(char, shift)
  if char >= 'a' && char <= 'z'
    (((char.ord - 'a'.ord + shift) % 26) + 'a'.ord).chr
  elsif char >= 'A' && char <= 'Z'
    (((char.ord - 'A'.ord + shift) % 26) + 'A'.ord).chr
  else
    char
  end
end

def caesar_cipher(str, shift)
  str.chars.map { |char| rotate(char, shift) }.join
end

puts caesar_cipher("Go is better than Ruby smh", 7)