class Journey

  attr_reader :entry, :exit
  @@history = []
  DEFAULT_ACTION = "no info"
  MINIMUM_FARE = 1.00
  PENALTY_FARE = 6.00

  def self.history
    @@history
  end

  def fare
    return PENALTY_FARE if @exit == DEFAULT_ACTION
    MINIMUM_FARE
  end

  def initialize(entry, exit=DEFAULT_ACTION)
    @entry = entry
    @exit = exit
  end

  def update_history
    @@history << { entry: @entry, exit: @exit }
  end
end
