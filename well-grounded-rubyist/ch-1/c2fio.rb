print "Enter a file path with a temperature in Celcius: "
path = gets.chomp
celcius = File.read(path).to_i
fahrenheit = (celcius * 9 / 5) + 32
puts "Saving result to output file 'temp.out'"
new_file = File.new("temp.out", "w")
new_file.puts fahrenheit
new_file.close
