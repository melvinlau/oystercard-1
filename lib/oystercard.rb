
class Oystercard
  attr_reader :entry_station, :history

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(money)
    if @balance + money > MAXIMUM_BALANCE
      "Balance limit exceeded. Please top up #{MAXIMUM_BALANCE - @balance} or less"
    else
      "Card balance: #{@balance += money}"
    end
  end

  def in_journey
    !@entry_station.nil? ? true : false
  end

  def balance
    @balance
  end

  def touch_in(station)
    return "Insufficient funds. Card balance: #{@balance}" if insufficient_funds?
    @entry_station = station
    @in_journey = true
    show_balance
  end

  def touch_out(station)
    @exit_station = station
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
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
    update_history
  end

  def update_history
    @history << {entry: @entry_station, exit: @exit_station, fare: @fare}
  end

end
