def add (x, y)
	x + y
end

def subtract(x, y)
	x - y
end

def sum (a)
	a.inject(0) {|i, number| i + number}
end

def multiply(*numbers)
	numbers.inject(1) {|i, number| i * number}
end

def power(x, y)
	x ** y
end

counter = 0
def factorial(x)
	init = x
	if x == 0
		res = 0
	else
		res = 1
		x.times do |i|
			res *= init
			init -=1
		end
	end
	res
end
puts factorial(5)