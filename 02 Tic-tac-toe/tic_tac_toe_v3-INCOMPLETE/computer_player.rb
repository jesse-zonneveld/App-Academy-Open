class Computer
    def initialize(mark)
        @mark = mark
    end

    attr_accessor :mark

    def get_position(legal_positions)
       pos = legal_positions.sample
       p "The computer went at #{pos}"
       pos
    end
end