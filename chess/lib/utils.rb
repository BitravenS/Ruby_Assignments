def coords_to_algebraic(coords)
  row, col = coords
  col_letter = ('a'..'h').to_a[col]
  row_number = 8 - row
  "#{col_letter}#{row_number}"
end

def algebraic_to_coords(algebraic)
  col_letter = algebraic[0]
  row_number = algebraic[1].to_i
  col = col_letter.ord - 'a'.ord
  row = 8 - row_number
  [row, col]
end

def clear_screen
  system('clear') || system('cls')
end
