module Stepable
    def moves
        move_dirs.each_with_object([]) do |(dx, dy), moves_arr|
            cur_x, cur_y = pos
            new_pos = [cur_x + dx, cur_y + dy]
            next unless board.valid_pos?(new_pos)

            if board.empty?(new_pos)
                moves_arr << new_pos
            elsif board[new_pos].color != color
                moves_arr << new_pos
            end
        end
    end

    private

    def move_dirs
        #raises error if not implemented properly from subclasses
        raise NotImplementedError
    end
end