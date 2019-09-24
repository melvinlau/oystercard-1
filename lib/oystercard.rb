
class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    if @balance + money > MAXIMUM_BALANCE
      "Balance limit exceeded. Please top up #{MAXIMUM_BALANCE - @balance} or less"
    else
      "Card balance: #{@balance += money}"
    end
  end

  def deduct(fare)
    "Card balance: #{@balance -= fare}"
  end

  def touch_in
    return "Insufficient funds. Card balance: #{@balance}" if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end


  attr_reader :in_journey

end
