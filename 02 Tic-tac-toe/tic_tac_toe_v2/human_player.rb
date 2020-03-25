class Human_player
    def initialize(mark)
        @mark = mark
    end

    attr_accessor :mark

    def get_position
        p "Player #{@mark}: Please enter a position in the form of [ 1 3 ]"
        pos = gets.chomp.split(" ").map(&:to_i)
        raise "error" if pos.length != 2
        pos
    end
end
