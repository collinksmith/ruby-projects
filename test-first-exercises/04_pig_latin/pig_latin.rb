def translate(words)
	vowels = ['a', 'e', 'i', 'o', 'u']
	words = words.split
	words.each do |word|
		if word[0..1] == 'qu'
			i = words.index(word)
			word = word[2..-1] + word[0..1] + 'ay'
			words[i] = word	
		elsif word[1..2] == 'qu' and word[0] != 'a' and word[0] != 'e' and word[0] != 'i' and word[0] != 'o' and word[0] != 'u'
			i = words.index(word)
			word = word[3..-1] + word[0..2] + 'ay'
			words[i] = word			
		elsif vowels.include? word[0]
			i = words.index(word)
			word = word +'ay'
			words[i] = word
		elsif vowels.include? word[1]
			i = words.index(word)
			word = word[1..-1] + word[0] + 'ay'
			words[i] = word			
		elsif vowels.include? word[2]
			i = words.index(word)
			word = word[2..-1] + word[0..1] + 'ay'
			words[i] = word
		else
			i = words.index(word)
			word = word[3..-1] + word[0..2] + 'ay'
			words[i] = word			

		end
	end
	words = words.join(' ')
	words
end