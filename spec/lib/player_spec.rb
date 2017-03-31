require "spec_helper"
require "lib/cards"
require "lib/priority"
require "lib/strategy"
require "lib/strategy_generator"
require "lib/player"

describe Player do
  describe "#take_turn" do
    it "buys cards" do
      strategy = Strategy.new(
        buy_priorities: [:gold, :gold],
        play_priorities: [],
      )
      gold = Cards::Gold.new
      allow(Cards::Gold).to receive(:new).and_return(gold)
      deck = [
        Cards::Gold.new,
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Copper.new,
      ]
      player = Player.new(strategy, deck)

      player.take_turn

      expect(player.cards.length).to eq(6)
      expect(player.cards).to match_array(deck + [gold])
    end

    it "plays cards as long as it has actions left" do
      strategy = Strategy.new(
        buy_priorities: [:gold],
        play_priorities: [:village, :smithy],
      )
      gold = Cards::Gold.new
      allow(Cards::Gold).to receive(:new).and_return(gold)
      cards = [
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Village.new,
        Cards::Smithy.new,
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Copper.new,
        Cards::Copper.new,
      ]
      player = Player.new(strategy, unshuffleable_deck(cards))

      player.take_turn

      expect(player.cards).to match_array(cards + [gold])
    end

    describe "#draw_cards" do
      context "when you try to draw more cards than you own" do
        it "returns all of the cards not in your hand" do
          player = Player.new(
            strategy: Strategy.new(
              buy_priorities: [],
              play_priorities: [],
            ),
          )

          player.draw_cards(11)

          expect(player.hand.size).to eq(10)
        end
      end

      it "draws a card" do
        player = Player.new(strategy: blank_strategy)

        player.draw_new_hand!
        number_of_cards = player.hand.size
        player.draw_cards(1)

        expect(player.hand.size).to eq(number_of_cards + 1)
      end
    end
  end
end
