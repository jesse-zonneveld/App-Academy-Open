require "colorize"

class Piece
    attr_reader :color, :board
    attr_accessor :pos

    def initialize(color, board, pos)
        raise "not a valid color, must be black or white." unless [:white, :black].include?(color)
        raise "not a valid position on the board." unless board.valid_pos?(pos)

        @color, @board, @pos = color, board, pos
        @board.add_piece(self, pos)
    end

    def symbol
        # subclass implements this with method
        raise NotImplementedError
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        false
    end

    def inspect
        # { class: self.class,
        #   color: color, 
        #   pos: pos }.inspect
          { class: self.class }.inspect
    end

    def valid_moves
        moves.reject { |end_pos| moves_into_check?(end_pos) }
    end

    private

    def moves_into_check?(end_pos)
        test_board = board.dup
        test_board.move_piece!(pos, end_pos)
        test_board.in_check?(color)
    end
    
end