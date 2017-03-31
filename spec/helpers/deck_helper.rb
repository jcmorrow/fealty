module DeckHelper
  def unshuffleable_deck(cards)
    cards.dup.tap do |new_deck|
      allow(new_deck).to receive(:dup).and_return(new_deck)
      allow(new_deck).to receive(:shuffle).and_return(new_deck)
    end
  end
end

RSpec.configure do |config|
  config.include DeckHelper
end
