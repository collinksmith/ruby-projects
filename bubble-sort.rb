def bubble_sort(array)
  unsorted = true
  count = 0
  while count < array.length
    # print "===Iteration #{count}===\n"
    array.each_index do |index|
      # print "#{array}Comparing #{array[index]} and #{array[index+1]}\n"
      if index < array.length-1
        if array[index] > array[index+1]
          still_sorting = true
          array = array[0...index] << array[index+1] << array[index] << array[index+2..-1]
          array.flatten!
        end
      end
    end
    count += 1
  end
  array
end


def bubble_sort_tester
  j = 60
  puts "[4,3,78,2,0,2] Should return: [0, 2, 2, 3, 4, 78]".rjust(j)
  puts "Returns: #{bubble_sort([4,3,78,2,0,2])}".rjust(j), "\n"

end
bubble_sort_tester