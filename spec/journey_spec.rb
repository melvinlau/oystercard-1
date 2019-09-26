require 'journey'

describe Journey do
  let(:journey) { described_class.new("entry", "exit", 1.00) }
  let(:journey2) {described_class.new("bank", "temple", 1.00)}

  it "initializes with an empty history" do
    expect(described_class.history).to eq []
  end

  # describe '#log' do
  #   it 'logs most recent completed journeys' do
  #     expect(journey.log).to eq({ entry: "entry", exit: "exit", fare: 1.00 })
  #   end
  # end

  describe "#update_history" do
    it "pushes the first complete journey log into the journey history" do

      expected_outcome = [{entry: "entry", exit: "exit", fare: 1.00 }]
      # expect(journey.update_history).to eq Journey.history
      expect(journey.update_history).to eq expected_outcome
    end

    # it "pushes subsequent complete journies into the journey history" do
    # ()
    #   journey.log
    #   journey.update_history
    #   journey2.log
    #   expected_outcome = [ {entry: "entry", exit: "exit", fare: 1.00 },
    #     {entry: "bank", exit: "temple", fare: 1.00 } ]
    #   expect(journey2.update_history).to eq expected_outcome
    # end
  end



end
