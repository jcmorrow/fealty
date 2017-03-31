module StrategyHelper
  def blank_strategy
    Strategy.new(buy_priorities: [], play_priorities: [])
  end

  def smithy_village_strategy
    Strategy.new(
      buy_priorities: [Province * 8, Gold * 6, Smithy * 3, Village * 3].flatten,
      play_priorities: [Village, Smithy, Gold, Silver, Copper],
    )
  end
end

RSpec.configure do |config|
  config.include StrategyHelper
end
