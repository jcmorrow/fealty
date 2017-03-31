class StrategyGenerator
  def self.random(size = 100)
    Strategy.new(
      buy_priorities: provinces.concat(random_buy_priorities(size)),
      play_priorities: random_play_priorities,
    )
  end

  def self.mutate(strategy)
    Strategy.new(
      buy_priorities: mutate_array(strategy.buy_priorities),
      play_priorities: mutate_array(strategy.play_priorities),
    )
  end

  def self.random_buy_priorities(size)
    Array.new(size) { random_buy_priority }
  end

  def self.random_play_priorities
    Cards::ACTION_CLASSES.shuffle
  end

  def self.random_buy_priority
    Cards::CLASSES.sample
  end

  def self.mutate_array(array)
    index = Random.rand(array.size - 1)
    array[index], array[index + 1] = array[index + 1], array[index]
    array
  end

  def self.provinces
    [Cards::Province] * 10
  end
end
