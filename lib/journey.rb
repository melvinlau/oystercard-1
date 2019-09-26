class Journey

  attr_reader :entry, :exit, :fare
  @@history = []

  def self.history
    @@history
  end

  def initialize(entry, exit, fare)
    @entry = entry
    @exit = exit
    @fare = fare

  end

  def update_history
    @@history << { entry: @entry, exit: @exit, fare: @fare }
  end
end
