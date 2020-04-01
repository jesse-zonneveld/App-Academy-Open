require_relative "board"
require_relative "human_player"

class Game
    attr_reader :board, :display, :players, :current_player

    def initialize
        @board = Board.new
        @display = Display.new(board)
        @players = { white: HumanPlayer.new(:white, display), black: HumanPlayer.new(:black, display) }
        @current_player = :white
    end

    def change_player
        @current_player = (current_player == :white ? :black : :white)
    end

    def play
        welcome_message
        until board.checkmate?(current_player)
            # display.render
            take_turn
            change_player
            notify
        end
        final_message
    end

    def take_turn
        begin
            start_pos, end_pos = players[current_player].make_move
            board.move_piece(current_player, start_pos, end_pos)
        rescue StandardError => e
            @display.notifications[:error] = e.message
            retry
        end
    end

    def notify
        if board.in_check?(current_player)
            display.set_check!
        else
            display.uncheck!
        end
    end

    def welcome_message
        system("clear")
        puts "~~~~~Welcome to the game of Chess~~~~~".green
        sleep(2)
    end

    def final_message
        puts "#{current_player} has lossed!"
        sleep(2)
        puts "Thanks for playing!"
    end
end

if $PROGRAM_NAME == __FILE__
    game = Game.new
    game.play
end
