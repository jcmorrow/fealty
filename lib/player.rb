class Player
  attr_reader :deck, :actions, :hand
  attr_accessor :treasure

  DEFAULT_DECK = [
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Copper.new,
    Cards::Estate.new,
    Cards::Estate.new,
    Cards::Estate.new,
  ].freeze

  def initialize(strategy, deck = DEFAULT_DECK, discard_pile = [])
    @deck = deck.dup.shuffle
    @discard_pile = discard_pile
    @strategy = strategy
    @hand = []
    @played_area = []
    draw_new_hand!
  end

  def draw_cards(number_of_cards)
    if deck.size < number_of_cards
      recycle_discard_pile!
    end

    hand.concat(deck.pop(number_of_cards))
  end

  def gain_actions(number_of_actions)
    @actions += number_of_actions
  end

  def gain_treasure(amount_of_treasure)
    @treasure += amount_of_treasure
  end

  def take_turn
    @actions = 1
    @treasure = 0

    next_play = strategy.next_play(hand, actions)
    while next_play
      play(next_play)
      next_play = strategy.next_play(hand, actions)
    end

    hand.select(&:treasure?).each { |card| play(card) }

    next_buy = strategy.next_buy(cards, treasure)
    while next_buy
      buy(next_buy)
      next_buy = strategy.next_buy(cards, treasure)
    end

    discard_pile.concat(Array(played_area))
    @played_area = []
    draw_new_hand!
  end

  def cards
    deck + hand + discard_pile + played_area
  end

  def draw_new_hand!
    discard_pile.concat(Array(hand))
    @hand = []
    draw_cards(5)
  end

  def points
    cards.select(&:victory?).map(&:points).reduce(&:+)
  end

  private

  attr_accessor :discard_pile, :played_area, :strategy

  def buy(card)
    @treasure -= card.cost
    discard_pile << card.buy
  end

  def play(card)
    card.play(self)
    played_area << hand.delete(card)
  end

  def recycle_discard_pile!
    deck.concat(discard_pile.shuffle)
    @discard_pile = []
  end
end
