require_relative "journey"
class Oystercard
  attr_reader :entry_station, :balance, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(money)
    if @balance + money > MAXIMUM_BALANCE
      "Balance limit exceeded. Please top up #{MAXIMUM_BALANCE - @balance} or less"
    else
      "Card balance: #{@balance += money}"
    end
  end

  def touch_in(station)
    return "Insufficient funds. Card balance: #{@balance}" if insufficient_funds?
    check_for_last_touch_out
    journey.start(station)
    show_balance
  end

  def check_for_last_touch_out
    if journey.exit_station.nil?
      deduct(journey.penalty_fare)
      "Penalty fare deducted because you didn't touch out"
    end
  end

  def touch_out(station)
    journey.end(station)
    deduct(journey.fare)
    show_balance
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def show_balance
    "Card balance: #{@balance}"
  end

  private

  def deduct(fare)
    @fare = fare
    @balance -= fare
  end

end
