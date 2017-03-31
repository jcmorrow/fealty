require "spec_helper"
require "lib/cards"
require "lib/priority"

describe Priority do
  describe "#permanent?" do
    it "defaults to false" do
      expect(Priority.new(:smithy)).not_to be_permanent
    end

    it "can be set to true" do
      expect(Priority.new(:smithy, permanent: true)).to be_permanent
    end
  end
end
