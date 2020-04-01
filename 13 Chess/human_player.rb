require_relative 'display'

class HumanPlayer
    attr_reader :color, :display

    def initialize(color, display)
        @color, @display = color, display
    end

    def make_move
        start_pos, end_pos = nil, nil

        until start_pos && end_pos
            display.render

            if start_pos
                puts "Current player: #{color}\n Move to where?"
                end_pos = display.cursor.get_input
                display.reset! if end_pos
            else
                puts "Current player: #{color}\n Move from where?"
                start_pos = display.cursor.get_input
                display.reset! if start_pos
            end
        end
        [start_pos, end_pos]
    end
end