class Journey

  @@history = []
  DEFAULT_ACTION = "no info"
  MINIMUM_FARE = 1.00
  PENALTY_FARE = 6.00

  def self.history
    @@history
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
  end

  def fare
    return PENALTY_FARE if @entry_station.nil?
    return PENALTY_FARE if @exit_station.nil?
    MINIMUM_FARE
  end

  def update_history
    @@history << { entry: @entry_station, exit: @exit_station }
  end
end
