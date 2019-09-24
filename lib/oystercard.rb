
class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
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

end
