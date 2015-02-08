def bubble_sort(array)
  still_sorting = true
  iteration_count = 1
  while still_sorting
    still_sorting = false
    # print "===Iteration #{iteration_count}===\n"
    array[0...array.length-iteration_count].each_index do |index|
      # print "#{array}Comparing #{array[index]} and #{array[index+1]}\n"
      if array[index] > array[index+1]
        still_sorting = true
        array = array[0...index] << array[index+1] << array[index] << array[index+2..-1]
        array.flatten!
      end
    end
    iteration_count += 1
  end
  array
end


def bubble_sort_tester
  j = 60
  puts "[4,3,78,2,0,2] Should return: [0, 2, 2, 3, 4, 78]".rjust(j)
  puts "Returns: #{bubble_sort([4,3,78,2,0,2])}".rjust(j), "\n"

  # Test optimization (sould stop looping after the second iteration because nothing has changed)
  puts "[3,2,5,7,9,15,20] Should return: [2, 3, 5, 7, 9, 15, 20]".rjust(j)
  puts "Returns: #{bubble_sort([3,2,5,7,9,15,20])}".rjust(j), "\n"

end
bubble_sort_tester