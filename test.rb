a = [1,2,3]

def each_return(arr)
  arr.each do |x|
    if x == 3
      return 6
    end
  end
end

puts each_return(a)
