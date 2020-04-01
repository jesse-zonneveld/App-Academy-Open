require_relative "piece"

class Pawn < Piece
    def symbol
        '♟'.colorize(color)
    end

    def moves
        forward_steps + attacks
    end

    private

    def forward_steps
        cur_i, cur_j = pos
        step_one_pos = [cur_i + forward_dir, cur_j]
        return [] unless board.valid_pos?(step_one_pos) && board.empty?(step_one_pos)

        steps = [step_one_pos]
        step_two_pos = [cur_i + 2 * forward_dir, cur_j]
        steps << step_two_pos if at_start? && board.empty?(step_two_pos)
        steps
    end

    def attacks
        cur_i, cur_j = pos
        possible_attacks = [[cur_i + forward_dir, cur_j + 1], [cur_i + forward_dir, cur_j - 1]]
        possible_attacks.select do |attack_pos|
            next false unless board.valid_pos?(attack_pos) 
            next false if board.empty?(attack_pos)
            board[attack_pos].color != color
        end
    end

    def at_start?
        pos[0] == (color == :white ? 6 : 1)
    end

    def forward_dir
        color == :white ? -1 : 1
    end
end
