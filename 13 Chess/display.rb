require "colorize"
require_relative "board"
require_relative "cursor"

class Display
    attr_reader :board, :cursor, :notifications

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
        @notifications = {}
    end

    def build_display
        board.grid.map.with_index do |row, i|
            build_row(row, i)
        end
    end

    def build_row(row, i)
        row.map.with_index do |piece, j|
            color = determine_color(i, j)
            piece.to_s.colorize(color)
        end
    end

    def determine_color(i, j)
        if cursor.cursor_pos == [i, j] && cursor.selected
            color = :light_green
        elsif cursor.cursor_pos == [i, j]
            color = :light_red
        elsif (i + j).odd?
            color = :light_blue
        else
            color = :blue
        end
        { background: color }
    end

    def render
        system("clear")
        puts "Use arrow keys or WSAD to select piece, then press 'space' or 'enter' to confirm:"
        build_display.each do |row|
            puts row.join
        end

        @notifications.each do |_key, val|
            puts val
        end
    end

    def reset!
        @notifications.delete(:error)
    end

    def uncheck!
        @notifications.delete(:check)
    end

    def set_check!
        @notifications[:check] = "Check!"
    end

    # def run
    #     loop do
    #         render
    #         cursor.get_input
    #     end
    # end

    # if $PROGRAM_NAME == __FILE__
    #     d = Display.new(Board.new)
    #     d.run
    # end
end
