class Card
    def initialize(symbol)
        @symbol = symbol
        @face_up = false
    end

    attr_reader :symbol

    def display
        @face_up ? @symbol : " "
    end

    def reveal
        @face_up = true
    end

    def hide
        @face_up = false
    end

    def to_sym
        @symbol
    end

    def ==(other_card)
        self.symbol == other_card.symbol
    end

    def is_face_up?
        @face_up == true
    end
end