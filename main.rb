$: << File.expand_path("../lib/", __FILE__)

require "awesome_print"
require "byebug"
require "cards"
require "player"
require "priority"
require "strategy"
require "strategy_generator"
require "strategy_generation"

best_candidate = StrategyGenerator.random(10)

puts <<-DOC

Buy Strategy
============
#{best_candidate.buy_priorities.map(&:to_sym)}
DOC

puts <<-DOC

Play Strategy
============
#{best_candidate.play_priorities.map(&:to_sym)}
DOC

1_000.times do
  generation = StrategyGeneration.from_strategy(best_candidate)
  best_candidate = generation.evolve
end

puts <<-DOC

Buy Strategy
============
#{best_candidate.buy_priorities.map(&:to_sym)}
DOC

puts <<-DOC

Play Strategy
============
#{best_candidate.play_priorities.map(&:to_sym)}
DOC
