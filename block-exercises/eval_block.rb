def eval_block(*args, &prc)
  unless block_given?
    puts "NO BLOCK GIVEN"
    return nil
  end

  prc.call(*args)
end

# Example calls to eval_block
eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end
# Washington, Kerry won 23 votes.
# => nil

res = eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end
p res
# => 15

eval_block(1, 2, 3)
# => "NO BLOCK GIVEN"