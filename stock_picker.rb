def stock_picker(prices)
  # Find max day. If it's the first day, find the next highest.
  max_day = prices.index(prices.max)
  if max_day == 0
    max_day = prices.index(prices[1..-1].max)
  end

  # Find min day. If it's the last day, find the next lowest.
  min_day = prices.index(prices.min)
  if min_day == prices.length - 1
    min_day = prices.index(prices[0..-2].min)
  end

  # Find min day that's before the max day
  min_before_max = prices.index(prices[0..max_day].min)
  by_max = prices[max_day] - prices[min_before_max]

  #Find max day that's after the min day
  max_after_min = prices.index(prices[min_day..-1].max)
  by_min = prices[max_after_min] - prices[min_day]

  if min_day < max_day
    return "[#{min_day},#{max_day}] \# for a profit of $#{prices[max_day]} - $#{prices[min_day]} = $#{prices[max_day] - prices[min_day]}"
  else
    if by_max >= by_min
      return "[#{min_before_max},#{max_day}] \# for a profit of $#{prices[max_day]} - $#{prices[min_before_max]} = $#{by_max}"
    else
      return "[#{min_day},#{max_after_min}] \# for a profit of $#{prices[max_after_min]} - $#{prices[min_day]} = $#{by_min}"
    end

  end

end

def stock_picker_test()
  prices1 = [25, 3, 9, 27, 29, 23]
  puts "#{prices1} Should be: '[1,4] \# for a profit of $29 - $3 = $26'".rjust(80)
  puts "Result: '#{stock_picker(prices1)}'".rjust(80), "\n"

  prices2 = [35, 24, 11, 15, 27, 17]
  puts "#{prices2} Should be: '[2,4] \# for a profit of $27 - $11 = $16'".rjust(80)
  puts "Result: '#{stock_picker(prices2)}'".rjust(80), "\n"

  prices3 = [15, 26, 37, 22, 14, 32, 11]
  puts "#{prices3} Should be '[0,2] \# for a profit of $37 - $15 = $22'".rjust(80)
  puts "Result: '#{stock_picker(prices3)}'".rjust(80), "\n"

  prices4 = [46, 25, 39, 18, 36, 19, 3]
  puts "#{prices4} Should be '[3,4] \# for a profit of $36 - $18 = $18'".rjust(80)
  puts "Result: '#{stock_picker(prices4)}'".rjust(80), "\n"

  # TODO: Find the correct answer when it doesn't involve either the min or the max
  prices5 = [40, 56, 36, 15, 40, 12, 24, 8]
  puts "#{prices5} Should be '[3,4] \# for a profit of $40 - $15 = $25'".rjust(85)
  puts "Result: '#{stock_picker(prices5)}'".rjust(85), "\n"
end

stock_picker_test()
