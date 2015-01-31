class Timer
	def initialize
		@seconds = 0
	end

	def seconds
		@seconds
	end
	def seconds=(n)
		@seconds = n
	end
	def time_string
		s = @seconds % 60
		m = @seconds/60 % 60
		h = @seconds/60/60 % 60
		puts s, m, h
		if s.to_s.length == 1
			s = "0#{s}"
		end
		if m.to_s.length == 1
			m = "0#{m}"
		end
		if h.to_s.length == 1
			h = "0#{h}"
		end
		puts s, m, h
		"#{h}:#{m}:#{s}"
	end

end

time = Timer.new
time.time_string
