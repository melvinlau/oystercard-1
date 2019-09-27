class Journey

  @@history = []
  DEFAULT_ACTION = "no info"
  MINIMUM_FARE = 1.00
  PENALTY_FARE = 6.00

  def self.history
    @@history
  end

  def self.history=(history)
    @@history = history
  end

  # Getter methods
  def entry_station
    @entry_station
  end
  def exit_station
    @exit_station
  end
  def penalty_fare
      PENALTY_FARE
  end

  # Setter methods
  def start(entry_station)
    @exit_station = nil # reset the exit station to nil
    @entry_station = entry_station
  end
  def end(exit_station)
    @exit_station = exit_station
    update_history
    @exit_station
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
