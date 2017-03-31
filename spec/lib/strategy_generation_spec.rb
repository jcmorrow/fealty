require "spec_helper"
require "lib/cards"
require "lib/player"
require "lib/strategy"
require "lib/strategy_generator"
require "lib/strategy_generation"

describe StrategyGeneration do
  describe "#evolve" do
    it "produces a Strategy" do
      generation = StrategyGeneration.new

      best_candidate = generation.evolve

      expect(best_candidate).to be_a(Strategy)
    end
  end

  describe "#from_strategy" do
    it "produces variants of that strategy" do
      strategy = instance_double(Strategy)
      allow(StrategyGenerator).to receive(:mutate).and_return(strategy)

      generation = StrategyGeneration.from_strategy(strategy)

      expect(generation.strategies).to eq([strategy] * 100)
    end
  end
end
