class Board
    def initialize
        @grid = Array.new(3) { Array.new(3, '_') }
    end

    attr_reader :grid

    def valid?(pos)
        pos.all? { |length| length >= 0 && length < @grid.length }
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end

    def empty?(pos)
        self[pos] == '_'
    end

    def player_mark(pos, mark)
        raise "error" if !empty?(pos) || !valid?(pos) 
        self[pos] = mark
    end

    def print
        @grid.each do |row|
            puts row.join(" ")
        end
    end

    def win_row?(mark)
        @grid.any? { |row| row.all?(mark) }
    end

    def win_col?(mark)
        @grid.transpose.any? { |col| col.all?(mark) }
    end

    def win_diagonal?(mark)
        left_to_right = (0...@grid.length).all? do |i|
            pos = [i, i]
            self[pos] == mark
        end

        right_to_left = (0...@grid.length).all? do |i|
            row = i
            col = @grid.length - 1 - i
            pos = [row, col]
            self[pos] == mark
        end

        left_to_right || right_to_left
    end
      
    def win?(mark)
        self.win_col?(mark) || self.win_row?(mark) || self.win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? { |row| row.any?('_') }
    end

end

