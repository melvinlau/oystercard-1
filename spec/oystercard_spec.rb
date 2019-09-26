require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new }
  let(:entry_station) { double("station") }
  let(:exit_station) { double("station") }

  minimum_balance = described_class::MINIMUM_BALANCE
  fare = minimum_balance

  it 'initialises a new card with balance: 0' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do

    it 'expect oystercard to respond to top_up method' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'returns card balance after topping up' do
      expect(card.top_up(20)).to match("Card balance: #{card.balance}")
    end

    it 'expect oystercard balance to change by 5' do
      expect { card.top_up(5) }.to change { card.balance }.by(5)
    end

    it 'tells user balance limit exceeded' do
      expect(card.top_up(95)).to match("Balance limit exceeded. Please top up #{Oystercard::MAXIMUM_BALANCE - card.balance} or less")
    end

  end

  # describe "#in_journey" do
  #   it "responds to false when the card is instantiated" do
  #     expect(card.in_journey).to eq false
  #   end
  #   it "responds to true when the user has touched in" do
  #     card.top_up(minimum_balance)
  #     card.touch_in(entry_station)
  #     expect(card.in_journey).to eq true
  #   end
  #
  #   it "responds to false when the user has touched in and out" do
  #     card.touch_in(entry_station)
  #     card.touch_out(exit_station)
  #     expect(card.in_journey).to eq false
  #   end
  #
  # end

  describe "#touch_in" do

    context "with sufficient funds" do

      before(:each) do
        card.top_up(10)
        card.touch_in(entry_station)
      end

      it "creates a Journey and logs the entry station" do
        journey = Journey.new
        expect(journey.entry_station).to eq entry_station
      end

    end

    context "with insufficient funds" do
      it "returns a notification to user" do
        message = "Insufficient funds. Card balance: #{subject.balance}"
        expect(subject.touch_in(entry_station)).to eq message
      end

      # To check that journey does not start!

    end
  end

  describe "#touch_out" do

    before(:each) do
      card.top_up(10.0)
      card.touch_in(entry_station)
    end

    it "reduces the balance by the minimum fare amount" do
      old_balance = card.balance
      card.touch_out(exit_station)
      fare = minimum_balance
      new_balance = old_balance - fare
      expect(card.balance).to eq(new_balance)
    end

    # it "overrides the contents of entry_location to nil" do
    #   card.touch_out(exit_station)
    #   expect(card.entry_station).to be_nil
    # end

  end

  # describe "#history" do
  #   it "displays an empty array when card first initialized" do
  #     card.top_up(90)
  #     expect(card.history).to eq []
  #   end
  #
  #   it "display an array of historic journeys" do
  #     card.top_up(90)
  #     5.times do
  #       card.touch_in(entry_station)
  #       card.touch_out(exit_station)
  #     end
  #
  #     card_history = [
  #       {entry: entry_station, exit: exit_station, fare: fare},
  #       {entry: entry_station, exit: exit_station, fare: fare},
  #       {entry: entry_station, exit: exit_station, fare: fare},
  #       {entry: entry_station, exit: exit_station, fare: fare},
  #       {entry: entry_station, exit: exit_station, fare: fare}
  #     ]
  #     expect(card.history).to eq card_history
  #   end
  # end

end
