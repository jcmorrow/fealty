class Priority
  attr_reader :card_type

  CARDS_PREFIX = "Cards::".freeze

  def initialize(card_symbol, permanent: false)
    @card_symbol = card_symbol
    @card_type = Object.const_get(CARDS_PREFIX + card_symbol.to_s.capitalize)
    @permanent = permanent
  end

  def permanent?
    @permanent
  end

  def cost
    card_type.cost
  end

  def to_sym
    @card_symbol
  end
end
