require "spec_helper"
require "lib/cards"

module Cards
  describe Card do
    describe "#action?" do
      it "returns false" do
        expect(Card.new).not_to be_action
      end
    end

    describe ".to_sym" do
      it "returns the class of the card as a symbol" do
        expect(Copper.to_sym).to eq(:copper)
      end
    end

    describe ".*" do
      it "returns that many copies of itself" do
        expect(Card * 2).to eq([Card, Card])
      end
    end
  end
end
