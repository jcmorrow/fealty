module Cards
  class VictoryCard < Card
    def victory?
      true
    end
  end

  class Estate < VictoryCard
    def self.cost
      2
    end

    def points
      1
    end
  end

  class Duchy < VictoryCard
    def self.cost
      5
    end

    def points
      3
    end
  end

  class Province < VictoryCard
    def self.cost
      8
    end

    def points
      6
    end
  end
end
