require "./Board.rb"
require "./human_player.rb"
require "./computer_player.rb"

class Game
    def initialize(size, hash)
        @players = []
        hash.each do |mark, boolean|
            if boolean
                @players << Computer.new(mark)
            else
                @players << Human_player.new(mark)
            end
        end
        @current_p = @players.first
        @board = Board.new(size)
    end

    def switch_turn
        @current_p = @players.rotate!.first
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_p.get_position(@board.legal_positions)
            
            @board.player_mark(pos, @current_p.mark)
            if @board.win?(@current_p.mark)
                p "Yay! Player #{@current_p.mark} wins!!"
                return
            else
                self.switch_turn
            end
        end
        puts "DRAW"
    end


end

