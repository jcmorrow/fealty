require "spec_helper"
require "lib/cards"
require "lib/priority"
require "lib/strategy"

describe Strategy do
  describe "#next_buy" do
    it "returns the highest buy you can make" do
      buys = [:gold, :copper]
      deck = []
      strategy = Strategy.new(buy_priorities: buys, play_priorities: [])

      buy = strategy.next_buy(deck, 6)

      expect(buy).to eq(Cards::Gold)
    end

    it "always returns permanent priorities when you can afford them" do
      buys = [{ gold: { permanent: true } }, :copper]
      deck = [Cards::Gold.new]
      strategy = Strategy.new(buy_priorities: buys, play_priorities: [])

      buy = strategy.next_buy(deck, 6)

      expect(buy).to eq(Cards::Gold)
    end

    it "returns the highest buy you can make and don't already have" do
      buys = [:gold, :copper]
      deck = [Cards::Gold.new]
      strategy = Strategy.new(buy_priorities: buys, play_priorities: [])
      allow(Cards::Gold).to receive(:buy)

      buy = strategy.next_buy(deck, 6)

      expect(buy).to eq(Cards::Copper)
    end

    context "when you can't afford anything" do
      it "returns nil" do
        buys = [:gold]
        deck = [Cards::Gold]
        strategy = Strategy.new(buy_priorities: buys, play_priorities: [])
        allow(Cards::Gold).to receive(:buy)

        buy = strategy.next_buy(deck, 0)

        expect(buy).to be nil
      end
    end
  end

  describe "#next_play" do
    it "returns the highest play priority that is present in the hand" do
      first_gold = Cards::Gold.new
      second_gold = Cards::Gold.new
      _copper = Cards::Copper.new
      hand = [first_gold, _copper, second_gold]
      hand_after_first_play = [_copper, second_gold]
      strategy = Strategy.new(
        buy_priorities: [],
        play_priorities: [:gold, :copper],
      )

      first_play = strategy.next_play(hand, 1)
      second_play = strategy.next_play(hand_after_first_play, 1)

      expect(first_play).to eq(first_gold)
      expect(second_play).to eq(second_gold)
    end

    context "when you have no cards to play" do
      it "returns nil" do
        hand = [Cards::Copper.new]
        strategy = Strategy.new(
          buy_priorities: [],
          play_priorities: [:gold],
        )

        play = strategy.next_play(hand, 1)

        expect(play).to eq(nil)
      end
    end

    context "when you have action cards but no actions left" do
      it "returns nil" do
        hand = [Cards::Smithy.new]
        strategy = Strategy.new(
          buy_priorities: [],
          play_priorities: [:smithy],
        )

        play = strategy.next_play(hand, 0)

        expect(play).to eq(nil)
      end
    end
  end
end
