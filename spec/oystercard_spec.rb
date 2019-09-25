require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new }
  let(:aldgate) { double("station") }

  minimum_balance = described_class::MINIMUM_BALANCE

  it 'initialises a new card with balance: 0' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do

    it 'expect oystercard to respond to top_up method' do
      expect(card).to respond_to(:top_up)
    end

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

  describe "#in_journey" do
    it "responds to false when the card is instantiated" do
      expect(card.in_journey).to eq false
    end
    it "responds to true when the user has touched in" do
      card.top_up(minimum_balance)
      card.touch_in(aldgate)
      expect(card.in_journey).to eq true
    end

    it "responds to false when the user has touched in and out" do
      card.touch_in(aldgate)
      card.touch_out
      expect(card.in_journey).to eq false
    end

  end

  describe "#touch_in" do


    it 'should return message when touching in with balance below 1' do
      expect(subject.touch_in(aldgate)).to eq "Insufficient funds. Card balance: #{subject.balance}"
    end

    it "should take a station in order to remember journey start point" do
      card.top_up(10)
      card.touch_in(aldgate)
      expect(card.entry_station).to eq aldgate
    end

  end

  describe "#touch_out" do

    before(:each) do
      card.top_up(10.0)
      card.touch_in(aldgate)
    end

    it "responds to touch_out" do
      expect(card).to respond_to(:touch_out)
    end


    it "reduces the balance by the minimum fare amount" do
      old_balance = card.balance
      card.touch_out
      fare = minimum_balance
      new_balance = old_balance - fare
      expect(card.balance).to eq(new_balance)
    end

    it "overrides the contents of entry_location to nil" do
      card.touch_out
      expect(card.entry_station).to be_nil
    end

  end



end
