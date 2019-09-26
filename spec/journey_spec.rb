require 'journey'

describe Journey do
  let(:journey) { described_class.new("entry", "exit") }


  it "has a default warning value if exit station not given" do
    bad_j = described_class.new("entry")
    expect(bad_j.exit).to eq described_class::DEFAULT_ACTION
  end

  it "initializes with an empty history" do
    expect(described_class.history).to eq []
  end

  describe "#fare" do
    it "calculates a single fare if entry and exit stations are given" do
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end
    it "calculates a penalty fare if entry given but no exit station given" do
      bad_j = described_class.new("entry")
      expect(bad_j.fare).to eq 6.00
    end

  end

  describe "#update_history" do
    it "pushes the first complete journey log into the journey history" do
      expected_outcome = [{entry: "entry", exit: "exit"}]
      # expect(journey.update_history).to eq Journey.history
      expect(journey.update_history).to eq expected_outcome
    end
  end



end
