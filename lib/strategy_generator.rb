class StrategyGenerator
  def self.random(size = 10)
    Strategy.new(
      buy_priorities: default_priorities.concat(random_buy_priorities(size)),
      play_priorities: random_play_priorities,
    )
  end

  def self.mutate(strategy)
    Strategy.from_priorities(
      buy_priorities: mutate_array(strategy.buy_priorities),
      play_priorities: mutate_array(strategy.play_priorities),
    )
  end

  def self.random_buy_priorities(size)
    Array.new(size) { random_buy_priority }
  end

  def self.random_play_priorities
    play_priority_options.shuffle
  end

  def self.random_buy_priority
    buy_priority_options.sample
  end

  def self.buy_priority_options
    @_buy_priority_options ||= Cards::CLASSES.map(&:to_sym)
  end

  def self.play_priority_options
    @_play_priority_options ||= Cards::ACTION_CLASSES.map(&:to_sym)
  end

  def self.mutate_array(array)
    copy = array.dup
    index = Random.rand(copy.size - 1)
    copy[index], copy[index + 1] = copy[index + 1], copy[index]
    copy
  end

  def self.default_priorities
    [
      { province: { permanent: true } },
      { gold: { permanent: true } },
    ]
  end
end
