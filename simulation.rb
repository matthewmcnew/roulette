require './JamesBond.rb'
require './Martingale.rb'

def spin
	rand(-1..36)
end 

def print_spin(spin) 
	spin = "00" if spin == -1
	puts "Spin Value #{spin}"
end


inital_balance=1000

puts "Inital Balance: " + inital_balance.to_s

success = 0
100.times do

	strategy = Martingale.new(inital_balance,1505,2000)

	while strategy.keep_going?
		value = spin
		print_spin(value)
		strategy.result(value)
		puts ""
	end

	success = success + 1 if strategy.success?

	strategy = nil
end 

puts "\n Successful: #{success}"