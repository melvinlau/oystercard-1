require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new }
  let(:entry_station) { double("station") }
  let(:exit_station) { double("station") }

  minimum_balance = described_class::MINIMUM_BALANCE
  fare = minimum_balance
  let(:penalty_fare) { 6.00 }

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

  describe "#touch_in" do

    context "with sufficient funds" do

      before(:each) do
        card.top_up(10)
        card.touch_in(entry_station)
      end

      it "logs the entry station" do
        expect(card.journey.entry_station).to eq entry_station
      end

      it "deducts a penalty fare if user did not touch out in last journey" do
        expect { card.touch_in(entry_station) }.to change { card.balance }.by(-penalty_fare)
      end

    end

    context "with insufficient funds" do

      it "returns a notification to user" do
        message = "Insufficient funds. Card balance: #{subject.balance}"
        expect(subject.touch_in(entry_station)).to eq message
      end

      it "does not log an entry station" do
        expect(card.journey.entry_station).to eq nil
      end

    end
  end

  describe "#touch_out" do

    before(:each) do
      card.top_up(10.0)
    end

    it "reduces the balance by the minimum fare amount" do
      card.touch_in(entry_station)
      old_balance = card.balance
      card.touch_out(exit_station)
      fare = minimum_balance
      new_balance = old_balance - fare
      expect(card.balance).to eq(new_balance)
    end

    it "deducts the penalty fare if the user did not touch in" do
      expect{ card.touch_out(exit_station) }.to change { card.balance }.by(-penalty_fare)
    end

  end

end
