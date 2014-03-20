class Martingale

  def initialize(net_worth, goal, betting_limit)
    puts "#"*50
    puts "Creating A New Run: #{@net_worth}"
    @betting_limit = betting_limit
    @net_worth = net_worth
    @goal = goal
    @high_numbers = @low_numbers = 0
    @multiplier = 1
    @additonal = 0
    @runs = 0
    @highest_multipler = @multiplier

    @streak = 0
    @gambling = true
  end

  LOW = 5.freeze

  def result(value)

    gamble(value)
    return

    if @gambling
      gamble(value)
    else
      puts "No Gamble for #{value}"
    end

    if !(19..36).member?(value)
      @streak= @streak + 1
      if @streak == 3
        @gambling = true
      end
    else
      @streak = 0
      @gambling = false
    end
  end

  def gamble(value)
    @runs = @runs + 1
    if (19..36).member?(value)
      @high_numbers = @high_numbers + 1
      win = LOW + LOW
    else
      @low_numbers = @low_numbers +1
      win = 0
    end

    win = win*@multiplier + 2*@additonal
    bet = LOW*@multiplier + @additonal
    profit = win - bet

    puts "Profit #{profit}"
    puts "Additonal #{@additonal}"

    @net_worth = @net_worth + win

    handle_multipler(profit)
  end


  def keep_going?
    if (@multiplier*LOW) > @betting_limit
      print
      return false
    end

    if  (@multiplier*LOW + @additonal) > @net_worth || @net_worth > @goal
      print
      return false
    end

    puts "Net Worth: #{@net_worth.to_s}"
    puts "Betting: #{@multiplier*LOW + @additonal}"
    @net_worth = (@net_worth - LOW*@multiplier - @additonal) if @gambling

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
      @additonal = 0
      puts "Back to $#{LOW} Bet"
    else
      @additonal = @additonal + 1
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
    puts "Higest Bet #{@highest_multipler*LOW}"
  end
end
