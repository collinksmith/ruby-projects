'''
New idea: Loop through each number in prices
For each number, subtract every number before it and keep the largest of the results (add each to an array, and take .max).
Add each of these max numbers to a new array and take the max. This is the correct result.

'''

def stock_picker(prices)
  possibilities = []
  profits = []
  counter = 0
  (0...prices.length).each do |day|               # Go through each day
    (0...day).each do |first_day|                 # For each day, go through each prior day
      possibilities.push([[first_day,day], prices[day] - prices[first_day]])
      counter += 1
    end
  end
  (0...possibilities.length).each do |index|      # Make a list of the possible profits
    profits.push(possibilities[index][1]) 
  end
  answer = profits.index(profits.max)             # Choose the highest profit and save its index
  days = possibilities[answer][0]
  return "#{days} \# for a profit of $#{prices[days[1]]} - $#{prices[days[0]]} = $#{possibilities[answer][1]}"
end

def stock_picker_test()
  prices1 = [25, 3, 9, 27, 29, 23]
  puts "#{prices1} Should be: '[1, 4] \# for a profit of $29 - $3 = $26'".rjust(85)
  puts "Result: '#{stock_picker(prices1)}'".rjust(85), "\n"

  prices2 = [35, 24, 11, 15, 27, 17]
  puts "#{prices2} Should be: '[2, 4] \# for a profit of $27 - $11 = $16'".rjust(85)
  puts "Result: '#{stock_picker(prices2)}'".rjust(85), "\n"

  prices3 = [15, 26, 37, 22, 14, 32, 11]
  puts "#{prices3} Should be: '[0, 2] \# for a profit of $37 - $15 = $22'".rjust(85)
  puts "Result: '#{stock_picker(prices3)}'".rjust(85), "\n"

  prices4 = [46, 25, 39, 18, 36, 19, 3]
  puts "#{prices4} Should be '[3, 4] \# for a profit of $36 - $18 = $18'".rjust(85)
  puts "Result: '#{stock_picker(prices4)}'".rjust(85), "\n"

  # Done Find the correct answer when it doesn't involve either the min or the max
  prices5 = [40, 56, 36, 15, 40, 12, 24, 8]
  puts "#{prices5} Should be '[3, 4] \# for a profit of $40 - $15 = $25'".rjust(85)
  puts "Result: '#{stock_picker(prices5)}'".rjust(85), "\n"
end

stock_picker_test()
