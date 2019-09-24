require 'oystercard'

describe Oystercard do

  minimum_balance = described_class::MINIMUM_BALANCE

  it 'initialises a new card with balance: 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'expect oystercard to respond to top_up method' do
      expect(subject).to respond_to(:top_up)
    end

    it 'expect oystercard to respond to top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'returns card balance after topping up' do
      expect(subject.top_up(20)).to match("Card balance: #{subject.balance}")
    end

    it 'expect oystercard balance to change by 5' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it 'tells user balance limit exceeded' do
      expect(subject.top_up(95)).to match("Balance limit exceeded. Please top up #{Oystercard::MAXIMUM_BALANCE - subject.balance} or less")
    end

  end

  describe '#deduct' do

    it 'expect oystercard to respond to top_up method' do
      expect(subject).to respond_to(:deduct)
    end

    it 'expect fare to be deducted from oystercard balance' do
      expect { subject.deduct(2) }.to change { subject.balance }.by(-2)
    end

    it 'returns card balance after deducting' do
      expect(subject.deduct(2)).to match("Card balance: #{subject.balance}")
    end

  end

  describe "#in_journey" do
    it "responds to false when the card is instantiated" do
      expect(subject.in_journey).to eq false
    end
    it "responds to true when the user has touched in" do
      subject.top_up(minimum_balance)
      subject.touch_in
      expect(subject.in_journey).to eq true
    end

    it "responds to false when the user has touched in and out" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end


  end

  describe "#touch_in" do
    it "responds to touch_in" do
      expect(subject).to respond_to(:touch_in)
    end

    it 'should return message when touching in with balance below 1' do
      expect(subject.touch_in).to eq "Insufficient funds. Card balance: #{subject.balance}"
    end

  end

  describe "#touch_out" do
    it "responds to touch_out" do
      expect(subject).to respond_to(:touch_out)
    end
    it "reduces the balance by the minimum fare amount" do
      subject.top_up(10.0)
      subject.touch_in
      expect { subject.touch_out }.to change{subject.balance}.by(-minimum_balance)
    end

  end



end
