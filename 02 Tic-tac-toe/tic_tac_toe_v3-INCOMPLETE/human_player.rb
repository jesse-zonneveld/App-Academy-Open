class Human_player
    def initialize(mark)
        @mark = mark
    end

    attr_accessor :mark

    def get_position(legal_positions)
        p "Player #{@mark}: Please enter a position in the form of [ 1 3 ]"
        pos = gets.chomp.split(" ").map(&:to_i)
        while !legal_positions.include?(pos) 
            p "illegal position, try again"
            pos = gets.chomp.split(" ").map(&:to_i)
        end
        pos
    end
end
