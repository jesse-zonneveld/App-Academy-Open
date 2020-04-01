module Slideable
    HORIZONTAL_VERTICAL = [
        [-1, 0],
        [1, 0],
        [0, 1],
        [0, -1]
    ].freeze

    DIAGONAL = [
        [-1, 1],
        [1, 1],
        [1, -1],
        [-1, -1]
    ].freeze

    def moves
        move_dirs.each_with_object([]) { |(dx, dy), moves_arr| moves_arr.concat(movement_chain(dx, dy)) }
    end

    def horizontal_vertical
        HORIZONTAL_VERTICAL
    end

    def diagonal
        DIAGONAL
    end

    private

    def move_dirs
        #raises error if not implemented properly from subclasses
        raise NotImplementedError
    end

    def movement_chain(dx, dy)
        cur_x, cur_y = pos
        moves_arr = []
        loop do
            cur_x, cur_y = cur_x + dx, cur_y + dy
            new_pos = [cur_x, cur_y]
            break unless board.valid_pos?(new_pos)

            if board.empty?(new_pos)
                moves_arr << new_pos
            else
                moves_arr << new_pos if board[new_pos].color != color
                break
            end
        end
        moves_arr
    end
end