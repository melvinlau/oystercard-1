require 'journey'

describe Journey do
  let(:journey) { described_class.new("entry", "exit", 1.00) }

  it "initializes with an empty history" do
    expect(journey.history).to eq []
  end

  describe '#log' do
    it 'logs most recent completed journeys' do
      expect(journey.log).to eq({ entry: "entry", exit: "exit", fare: 1.00 })
    end
  end

  describe "#update_history" do
    it "pushes the latest complete journey log into the journey history" do

      # Previous journey
      allow(journey).to receive(:history) { [ {"aldgate", "liverpool street", 1.00} ] }



      # Current journey
      journey_two = Journey.new("bank", "temple", 1.00)
      journey.log

      expected_history = [
        {entry: "aldgate", exit: "liverpool street", 1.00},
        {entry: "bank", exit: "temple", 1.00}
      ]

      expect(journey.update_history).to eq expected_history
    end
  end



end
