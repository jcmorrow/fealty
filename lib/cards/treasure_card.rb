module Cards
  class TreasureCard < Card
    def treasure?
      true
    end

    def play(player)
      player.gain_treasure(value)
    end
  end

  class Gold < TreasureCard
    def self.cost
      6
    end

    def value
      3
    end
  end

  class Copper < TreasureCard
    def self.cost
      0
    end

    def value
      1
    end
  end

  class Silver < TreasureCard
    def self.cost
      3
    end

    def value
      2
    end
  end
end
