require 'oystercard'

describe Oystercard do

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

    it 'expect oystercard balance to change by 5' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

  end



end
