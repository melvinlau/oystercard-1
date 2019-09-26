class Journey
  attr_reader :entry, :exit, :fare, :history
  def initialize(entry, exit, fare)
    @entry = entry
    @exit = exit
    @fare = fare
    @history = []
  end
  def log
    { entry: @entry, exit: @exit, fare: @fare }
  end
end
