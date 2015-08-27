def bubble_sort_by(array)
  still_sorting = true
  iteration_count = 1
  while still_sorting
    still_sorting = false
    array[0...array.length-iteration_count].each_index do |index|
      if yield(array[index], array[index+1]) < 0
        still_sorting = true
        array = array[0...index] << array[index+1] << array[index] << array[index+2..-1]
        array.flatten!
      end
    end
    iteration_count += 1
  end
  array
end

def bubble_sort_by_tester
  j = 30
  puts 'bubble_sort_by(["hi","hello","hey"]) do |left,right|' + "\n" + 
    "\t right.length - left.length \n" +
    "end \n" +
    'Should be: ["hi", "hey", "hello"]'.rjust(j)
  res = bubble_sort_by(["hi","hello","hey"]) do |left,right|
        right.length - left.length
        end
  puts "Result is: #{res}".rjust(j)
end
bubble_sort_by_tester