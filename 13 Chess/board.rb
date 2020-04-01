require_relative "pieces"
require "byebug"

class Board

    attr_reader :null_piece, :grid

    def initialize(dup_bool = false)
        @null_piece = NullPiece.instance
        setup_board(dup_bool)
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def []=(pos, piece)
        x, y = pos
        @grid[x][y] = piece
    end

    def move_piece(cur_color, start_pos, end_pos)
        raise "Sorry, there isn't a chess piece located at that position." if self[start_pos] == nil
        moving_piece = self[start_pos]
        if moving_piece.color != cur_color
            raise "Sorry, you can't move the other player's piece." 
        elsif !moving_piece.moves.include?(end_pos)
            raise "Sorry, you can't move your piece to that location."
        elsif !moving_piece.valid_moves.include?(end_pos)
            raise "Sorry, you can't move into check."
        end

        move_piece!(start_pos, end_pos)
    end

    #moves piece regardless of if in check for the method moves_into_check
    def move_piece!(start_pos, end_pos)
        moving_piece = self[start_pos]
        self[start_pos] = @null_piece
        self[end_pos] = moving_piece
        moving_piece.pos = end_pos
    end

    def add_piece(piece, pos)
        raise "position not empty." unless self.empty?(pos)

        self[pos] = piece
    end

    def empty?(pos)
        self[pos] == @null_piece
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0,7) }
    end

    def in_check?(color)
        king_pos = find_king(color).pos
        pieces.any? { |piece| piece.color != color && piece.moves.include?(king_pos) }
    end

    def checkmate?(color)
        return false unless in_check?(color)
        pieces.select { |piece| piece.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def pieces
        grid.flatten.reject { |piece| piece.empty? }
    end

    def dup
        new_board = Board.new(true)
        pieces.each do |piece|
            piece.class.new(piece.color, new_board, piece.pos)
        end
        new_board
    end

    private

    def setup_board(dup_bool)
        @grid = Array.new(8) { Array.new(8, @null_piece) }
        return if dup_bool
        [:white, :black].each do |color| 
            set_back_row(color)
            set_pawn_row(color) 
        end
    end

    def set_back_row(color)
        back_row_layout = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        row = (color == :white ? 7 : 0)
        back_row_layout.each_with_index { |piece_class, y| piece_class.new(color, self, [row, y]) }
    end

    def set_pawn_row(color)
        back_row_layout = []
        row = (color == :white ? 6 : 1)
        8.times { |y| Pawn.new(color, self, [row, y]) }
    end

    def find_king(color)
        pieces.find { |piece| piece.color == color && piece.is_a?(King) }
    end
end

# if $PROGRAM_NAME == __FILE__
#     b = Board.new
#     p b.pieces
# end
