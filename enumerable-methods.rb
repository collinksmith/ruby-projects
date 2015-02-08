include Enumerable

module Enumerable
  def my_each
    for i in (0...self.length)
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    for i in (0...self.length)
      yield(self[i], i)
    end
    self
  end

  def my_select
    res = []
    self.each do |e|
      res.push(e) if yield(e)
    end
    res
  end

  def my_all?
    self.each do |e|
      return false unless yield(e)
    end
    return true
  end

  def my_any?
    self.each do |e|
      return true if yield(e)
    end
    return false
  end

  def my_none?
    self.each do |e|
      return false if yield(e)
    end
    return true
  end

  def my_count
    count = 0
    self.each do |e|
      count += 1 if yield(e)
    end
    count
  end

  def my_map
    res = []
    self.each {|e| res.push(yield(e))}
    res
  end

  def my_inject(start={})
    if start == {}
      total = self[0]
      self[1..-1].each do |e|
        total = yield(total, e)
      end
    else
      total = start
      self.each do |e|
        total = yield(total, e)
      end
    end
    total
  end

  def my_map_proc(&proc)
    res = []
    self.each {|e| res.push(proc.call(e))}
    res
  end

  def my_map_proc_or_block(&proc)
    res = []
    self.each {|e| res.push(proc.call(e))}
    res
    if block_given?
      res2 = []
      self.each {|e| res2.push(yield(e))}
      res2
    end
  end

end

def multiply_els(array)
  array.my_inject {|t, i| t*i}
end

def enumerable_methods_tester
  j = 50
  a = [2,4,5,6,8,10,15,16,17]
  all_array_1 = [2,10,16]
  all_array_2 = [2,5,7,10]
  any_array_1 = [3,6,7,9]
  any_array_2 = [3,5,7,9]
  multiply_els_array = [2,4,5]
  times_two = Proc.new {|e| e * 2}

  puts "Unless otherwise noted, all tests are done on the array: #{a}\n"
  
  puts "===Testing my_each==="
  print "each:    " 
  a.each {|e| print "#{e} "}
  puts
  print "my_each: "
  a.my_each {|e| print "#{e} "}
  puts "\n\n"

  puts "===Testing my_each_with_index==="
  print "each_with_index:    " 
  a.each_with_index {|e, i| print "e: #{e}. i: #{i}."}
  puts
  print "my_each_with_index: " 
  a.my_each_with_index {|e, i| print "e: #{e}. e: #{i}."}
  puts "\n\n"

  puts "===Testing my_select==="
  puts "select:    #{a.select {|e| e%2==0}}"
  puts "my_select: #{a.my_select {|e| e%2==0}} \n\n"

  puts "===Testing my_all?==="
  puts "---#{all_array_1} all even?---"
  puts "all?:    #{all_array_1.all? {|e| e%2==0}}"
  puts "my_all?: #{all_array_1.my_all? {|e| e%2==0}}"
  puts "---#{all_array_2} all even?---"
  puts "all?:    #{all_array_2.all? {|e| e%2==0}}"
  puts "my_all?: #{all_array_2.my_all? {|e| e%2==0}}\n\n"

  puts "===Testing my_any?==="
  puts "---#{any_array_1} any even?---"
  puts "any?:    #{any_array_1.any? {|e| e%2==0}}"
  puts "my_any?: #{any_array_1.my_any? {|e| e%2==0}}"
  puts "---#{any_array_2} any even?---"
  puts "any?:    #{any_array_2.any? {|e| e%2==0}}"
  puts "my_any?: #{any_array_2.my_any? {|e| e%2==0}}\n\n"

  puts "===Testing my_none?==="
  puts "---#{any_array_1} none even?---"
  puts "none?:    #{any_array_1.none? {|e| e%2==0}}"
  puts "my_none?: #{any_array_1.my_none? {|e| e%2==0}}"
  puts "---#{any_array_2} none even?---"
  puts "none?:    #{any_array_2.none? {|e| e%2==0}}"
  puts "my_none?: #{any_array_2.my_none? {|e| e%2==0}}\n\n"

  puts "===Testing my_count==="
  puts "---#{any_array_1} how many even?---"
  puts "count:    #{any_array_1.count {|e| e%2==0}}"
  puts "my_count: #{any_array_1.my_count {|e| e%2==0}}"
  puts "---#{any_array_2} how many even?---"
  puts "count:    #{any_array_2.count {|e| e%2==0}}"
  puts "my_count: #{any_array_2.my_count {|e| e%2==0}}\n\n"

  puts "===Testing my_map==="
  puts "---#{a}: mapped to '* 2'---"
  puts "map:    #{a.map {|e| e * 2}}"
  puts "my_map: #{a.my_map {|e| e * 2}}\n\n"

  puts "===Testing my_inject==="
  puts "---#{a}: add each number, starting with 5---"
  puts "inject:    #{a.inject() {|t, i| t+i}}"
  puts "my_inject: #{a.my_inject() {|t, i| t+i}}"
  puts "---Testing via multiply_els, with #{multiply_els_array}"
  puts "multiply_els: #{multiply_els(multiply_els_array)}\n\n"

  puts "===Testing my_map_proc==="
  puts "---#{a}: mapped to '* 2'---"
  puts "map:         #{a.map {|e| e * 2}}"
  puts "my_map_proc: #{a.my_map_proc(&times_two)}\n\n"

  puts "===Testing my_map_proc_or_block==="
  puts "---With proc:---"
  puts "map:                  #{a.map {|e| e * 2}}"
  puts "my_map_proc_or_block: #{a.my_map_proc_or_block(&times_two)}"
  puts "---With block---"
  puts "map:                  #{a.map {|e| e * 2}}"
  puts "my_map_proc_or_block: #{a.my_map_proc_or_block {|e| e * 2}}"
  # puts "---With both---"
  # puts "map:    #{a.map {|e| e * 2}}"
  # puts "my_map_proc_or_block: #{a.my_map_proc_or_block(&times_two) {|e| e ** 2}}\n\n"
end

# Run the tests if the file is run as a top-level script
enumerable_methods_tester if $0 == __FILE__