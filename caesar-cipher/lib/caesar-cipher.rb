def caesar_cipher(string, shift_factor)
  modified_chars = string.chars.map do |char|
    case char
    when 'a'..'z'
      ((char.ord - 'a'.ord + shift_factor) % 26 + 'a'.ord).chr
    when 'A'..'Z'
      ((char.ord - 'A'.ord + shift_factor) % 26 + 'A'.ord).chr
    else char
    end
  end
  modified_chars.join
end
