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

def caesar_cipher_test()
  puts "Tests with a key of 5:"
  puts "'What is your name?' Should be: 'Bmfy nx dtzw sfrj?'".rjust(80)
  puts "Result: '#{caesar_cipher("What is your name?", 5)}'".rjust(80), "\n"
  puts "'Ruby is the greatest language!' Should be: 'Wzgd nx ymj lwjfyjxy qfslzflj!'".rjust(80)
  puts "Result: '#{caesar_cipher("Ruby is the greatest language!", 5)}'".rjust(80), "\n"

  puts "Tests with a key of 22:"
  puts "'What is your name?' Should be: 'Sdwp eo ukqn jwia?'".rjust(80)
  puts "Reult: '#{caesar_cipher("What is your name?", 22)}'".rjust(80), "\n"
  puts "'Ruby is the greatest language!' Should be:'Nqxu eo pda cnawpaop hwjcqwca!'".rjust(80)
  puts "Result: '#{caesar_cipher("Ruby is the greatest language!", 22)}'".rjust(80), "\n"
end

caesar_cipher_test()