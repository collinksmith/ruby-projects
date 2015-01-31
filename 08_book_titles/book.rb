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


class Book
	def initialize
		@title = ''
	end

	def title
		@title
	end

	def title=(input)
		noncaps = ['the', 'over', 'and', 'of', 'in', 'a', 'an']
		array = input.split
		array.each do |word|
			unless noncaps.include? word
				i = array.index(word)
				word = word.capitalize
				array[i] = word
			end
			if array.index(word) == 0
				i = array.index(word)
				word = word.capitalize
				array[i] = word
			else
			end
		end
		@title = array.join(' ')
		@title
	end

end
# ((word != 'the') and (word != 'over') and (word != 'and')) and (word != 'of') and (word != 'in')