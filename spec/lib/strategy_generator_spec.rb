require "spec/spec_helper"
require "lib/cards"
require "lib/priority"
require "lib/strategy"
require "lib/strategy_generator"

describe StrategyGenerator do
  describe ".random" do
    it "returns a Strategy with random priorities" do
      expect(StrategyGenerator.random).to be_a(Strategy)
    end
  end

  describe ".mutate" do
    it "changes the order but not the contents of the priorities" do
      strategy = StrategyGenerator.random(5)
      old_buy_priorities = strategy.buy_priorities.dup
      old_play_priorities = strategy.play_priorities.dup

      new_strategy = StrategyGenerator.mutate(strategy)

      expect(old_buy_priorities).to match_array(strategy.buy_priorities)
      expect(old_play_priorities).to match_array(strategy.play_priorities)
      expect(new_strategy).not_to be(strategy)
    end
  end
end
