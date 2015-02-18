def caesar_cipher(input, key)
  letters = input.split('')
  letters.map! {|l| l.ord}
  letters.map! do |l|
    if l >= 97 and l <= 122
      # change lowercase
      l += key
      if l > 122
        l -= 26
      end
    elsif l >= 65 and l <= 90
      # change uppercase
      l += key
      if l > 90
        l -= 26
      end
    else # don't change special characters
    end
    l
  end
letters.map! {|l| l.chr}
letters = letters.join
letters
end