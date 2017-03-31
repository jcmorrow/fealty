class StrategyGeneration
  attr_accessor :strategies, :strategy_points

  def initialize
    @strategies = Array.new(100) { StrategyGenerator.random(10) }
    @strategy_points = Hash.new
  end

  def self.from_strategy(strategy, count = 10)
    StrategyGeneration.new.tap do |generation|
      generation.strategies = Array.new(count - 1) do
        mutated_strategy = StrategyGenerator.mutate(strategy)
        while [true, true, true, false].sample
          mutated_strategy = StrategyGenerator.mutate(mutated_strategy)
        end
        mutated_strategy
      end
      generation.strategies << strategy
    end
  end

  def evolve
    strategies.each do |strategy|
      player = Player.new(strategy)
      20.times { player.take_turn }
      strategy_points[strategy] = player.points
    end
    sorted_points = strategy_points.sort { |a, b| b[1] <=> a[1] }
    average_points = strategy_points.
      map { |strat_points| strat_points[1] }.
      reduce { |sum, el| sum + el }.
      to_f / strategy_points.size
    puts average_points
    best_candidate = sorted_points.first
    best_candidate
  end
end
