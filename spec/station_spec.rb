require "station"

describe Station do

  # C-13 - In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in

  let(:station) { described_class.new("aldgate", 1) }

  describe "#name" do
    it "returns the station name" do
      expect(station.name).to eq ("aldgate")
    end
  end

  describe "#zone" do
    it "returns the station zone" do
      expect(station.zone).to eq 1
    end
  end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out


end
