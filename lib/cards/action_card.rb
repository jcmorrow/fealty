module Cards
  class ActionCard < Card
    def action?
      true
    end

    def play(player)
      player.gain_actions(number_of_actions)
      player.draw_cards(number_of_draws)
    end
  end

  class Village < ActionCard
    def self.cost
      3
    end

    def number_of_actions
      2
    end

    def number_of_draws
      1
    end
  end

  class Smithy < ActionCard
    def self.cost
      4
    end

    def number_of_draws
      3
    end
  end
end
