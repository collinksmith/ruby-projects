def echo(input)
	input
end

def shout(input)
	input.upcase
end

def repeat(input, n=2)
	res = ''
	n.times do |i|
		res << "#{input} "
	end
	res.rstrip
end

def start_of_word(word, n)
	word[0..n-1]
end
 def first_word(input)
 	res = ''
 	input.each_char do |i|
 		if i != ' '
 			res << i
 		else
 			break
 		end
 	end
 	res
 end

 def titleize(input)
 	array = input.split
 	array.each do |word|
 		if ((word != 'the') and (word != 'over') and (word != 'and')) or array.index(word) == 0
 			i = array.index(word)
 			word = word.capitalize
 			array[i] = word
 		else
 		end
 	end
 	array.join(' ')
 end

 puts titleize("jaws")