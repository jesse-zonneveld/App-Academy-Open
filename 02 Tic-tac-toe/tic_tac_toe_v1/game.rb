require "./Board.rb"
require "./human_player.rb"

class Game
    def initialize(mark_1, mark_2)
        @p1 = Human_player.new(mark_1)
        @p2 = Human_player.new(mark_2)
        @current_p = @p1
        @board = Board.new
    end

    def switch_turn
        return @current_p = @p2 if @current_p == @p1
        @current_p = @p1 if @current_p == @p2
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_p.get_position
            
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

