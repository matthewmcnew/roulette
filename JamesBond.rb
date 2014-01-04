class JamesBond

	def initialize(net_worth,goal,betting_limit)
		puts "#"*50
		puts "Creating A New Run: #{@net_worth}"
		@betting_limit = betting_limit
		@net_worth = net_worth
		@goal = goal
		@high_numbers = @low_numbers = @zeros = @middle_numbers = 0 
		@multiplier =  1 
		@runs = 0
		@highest_multipler = @multiplier
	end

	def result(value)
		@runs = @runs + 1
		if (19..36).member?(value)
			@high_numbers = @high_numbers + 1 
			win = 14 + 14
		elsif (13..18).member?(value)
			@middle_numbers = @middle_numbers + 1
			win = 5*5 + 5
		elsif (-1..0).member?(value)
			win = 17*1 + 1
			@zeros = @zeros +1
		else 
			@low_numbers = @low_numbers +1
			win = 0
		end 

		win = win*@multiplier 
		bet = 20*@multiplier
		profit = win - bet

		puts "Profit #{profit}"
		
		@net_worth = @net_worth + win

		handle_multipler(profit)
	end

	def keep_going?
		if (@multiplier*20) > @betting_limit
			puts print
			return false
		end

		if @net_worth < (@multiplier*20) || @net_worth > @goal 
			puts print
			return false
		end

		puts "Net Worth: #{@net_worth.to_s}"
		puts "Betting: #{@multiplier*20}"
		@net_worth = @net_worth - 20*@multiplier

		return true
	end

	def success?
		if @net_worth > @goal
			return true
		end
		return false
	end

	private

	def handle_multipler(win)
		if win > 0 
			@multiplier = 1
			puts "Back to $20 Bet"
		else
			@multiplier = @multiplier * 2
		end

		if @multiplier > @highest_multipler 
			@highest_multipler = @multiplier
		end
	end

	def print 
		puts "Run result: #{self.success?}"
		puts "Net Worth: #{@net_worth}"
		puts "Number of Runs: #{@runs}"
		puts "Higest Bet #{@highest_multipler*20}"
	end


end