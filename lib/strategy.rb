class Strategy
  attr_reader :buy_priorities, :play_priorities

  def initialize(buy_priorities:, play_priorities:)
    @buy_priorities = buy_priorities.map { |options| Priority.new(options) }
    @play_priorities = play_priorities.map { |options| Priority.new(options) }
  end

  def next_buy(cards, money)
    priorities = buy_priorities.dup
    cards.each do |card|
      priority_index = priorities.map(&:card_type).index(card.class)
      if priority_index && !priorities[priority_index].permanent?
        priorities.delete_at(priority_index)
      end
    end
    priorities.detect { |buy| money >= buy.cost }&.card_type
  end

  def next_play(hand, actions)
    play_priorities.map do |priority|
      hand.detect do |card|
        card.class == priority.card_type && (!card.action? || actions.positive?)
      end
    end.compact.first
  end
end
