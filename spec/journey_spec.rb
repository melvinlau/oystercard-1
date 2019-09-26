require 'journey'

describe Journey do

  let(:journey) { described_class.new }
  let(:entry_station) { "Bank" }
  let(:exit_station) { "Waterloo" }

  it "initializes with an empty history" do
    expect(described_class.history).to eq []
  end

  describe "#start" do
    it "returns the entry station" do
      expect(journey.start(entry_station)).to eq entry_station
    end
  end

  describe "#end" do
    it "returns an exit station" do
      expect(journey.end(exit_station)).to eq exit_station
    end
  end

  # REDUNDANT `IT` BLOCK?
  # it "has a default warning value if exit station not given" do
  #   no_exit_journey = described_class.new
  #   no_exit_journey.start = entry_station
  #   expect(no_exit_journey.exit).to eq described_class::PENALTY
  # end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  describe "#fare" do
    it "calculates a single fare if entry and exit stations are given" do
      journey.start(entry_station)
      journey.end(exit_station)
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end

    it "calculates a penalty fare if user touches out without touching in" do
      bad_journey = described_class.new
      bad_journey.end(exit_station)
      expect(bad_journey.fare).to eq described_class::PENALTY_FARE
    end

    it "calculates a penalty fare if user touches in twice (i.e. didn't touch out)" do
      bad_journey = described_class.new
      bad_journey.start(entry_station)
      bad_journey.start(entry_station)
      expect(bad_journey.fare).to eq described_class::PENALTY_FARE
    end

  end

  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips
  describe "#update_history" do
    it "logs the first completed journey into the journey history" do
      described_class.history = [] # Is there a way to avoid doing this?
      journey.start(entry_station)
      journey.end(exit_station)
      expected_history = [ { entry: entry_station, exit: exit_station } ]
      expect(described_class.history).to eq expected_history
    end
  end



end
