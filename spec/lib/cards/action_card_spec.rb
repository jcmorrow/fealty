require "spec_helper"
require "lib/cards"

module Cards
  describe ActionCard do
    describe "#action?" do
      it "returns true" do
        expect(ActionCard.new).to be_action
      end
    end
  end
end
