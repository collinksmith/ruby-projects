def substrings(string, dict)
  res = {}
  string.downcase!
  dict.each do |sub|
    sub.to_s
    # print "#{sub}, "
    counter = 0
    string.scan(/#{sub}/) do |s|
      counter += 1
      res["#{s}"] = counter
    end

  end
  return res
end

def substrings_tester()
  j = 130
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

  puts "'below'\n".rjust(j), "Should return: {'below'=>1, 'low'=>1}".rjust(j)
  puts "#{substrings('below', dictionary)}".rjust(j)

  puts "'Howdy partner, sit down! How's it going?'\n".rjust(j), "Should return: {'down'=>1, 'how'=>2, 'howdy'=>1,'go'=>1, 'going'=>1, 'it'=>2, 'i'=> 3, 'own'=>1,'part'=>1,'partner'=>1,'sit'=>1}".rjust(j)
  puts "#{substrings("Howdy partner, sit down! How's it going?", dictionary)}".rjust(j)
end

substrings_tester()