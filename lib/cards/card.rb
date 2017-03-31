module Cards
  class Card
    def self.buy
      new
    end

    def self.to_sym
      name.match(/Cards::(\w+)/)[1].downcase.to_sym
    end

    def self.*(number_of_copies)
      [self] * number_of_copies
    end

    def action?
      false
    end

    def treasure?
      false
    end

    def victory?
      false
    end

    def number_of_actions
      0
    end
  end
end
