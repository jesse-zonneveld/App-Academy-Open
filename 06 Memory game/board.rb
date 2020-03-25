require "./card.rb"

class Board

    def initialize(size)
        @size = size
        @grid = []
        self.populate(@size)
    end

    attr_reader :size

    def populate(size)
        cards = (:A..:Z).to_a
        grid = []
        while grid.length < (size * size)
            input = cards.sample
            cards.delete(input)
            grid << Card.new(input) << Card.new(input)
        end
        @grid = grid.shuffle.each_slice(4).to_a
        return true
    end

    def render
        @grid.map { |row| row.map { |sym| sym.display } }
        .each do |row|
            p row.join(" | ")
        end
    end

    def won?
        @grid.all? { |row| row.all? { |card| card.is_face_up? == true } }
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def reveal(pos)
        self[pos].reveal
    end
end