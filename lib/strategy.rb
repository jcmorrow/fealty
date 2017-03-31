class Strategy
  attr_reader :buy_priorities, :play_priorities

  def initialize(buy_priorities:, play_priorities:)
    @buy_priorities = buy_priorities
    @play_priorities = play_priorities
  end

  def next_buy(cards, money)
    priorities = buy_priorities.dup
    cards.each do |card|
      priorities.delete_at(
        priorities.index(card.class) || priorities.length,
      )
    end
    priorities.detect { |buy| money >= buy.cost }
  end

  def next_play(hand, actions)
    play_priorities.map do |play|
      hand.detect do |card|
        card.class == play && (!card.action? || actions.positive?)
      end
    end.compact.first
  end
end
