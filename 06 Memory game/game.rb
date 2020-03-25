require "./board.rb"
require "./human.rb"
require "./computer.rb"
require "./card.rb"
require "byebug"

class Game
    def initialize(size, players)
        @board = Board.new(size)
        @players = players
        @current_player = players[0]
    end

    attr_reader :current_player

    def next_player
        @players.rotate!
        @current_player = @players[0]
    end

    def run
        while !@board.won?
            @board.render
            self.take_turn
            self.next_player
        end
        p "yay you win"
    end

    def take_turn
        self.first_guess
        self.second_guess
        self.check_guesses
    end

    def check_guesses
        unless @board[@first_guess].symbol == @board[@second_guess].symbol
            @board[@first_guess].hide
            @board[@second_guess].hide
        end
    end

    def make_first_guess
        @first_guess = @current_player.get_input
        
    end

    def make_second_guess
        p "please enter a pos: "
        @second_guess = gets.chomp.split(" ").map(&:to_i)
        while !valid_guess?(@second_guess)
            p "not a valid guess"
            @second_guess = gets.chomp.split(" ").map(&:to_i)
        end
        @second_guess
    end

    def valid_guess?(guess)
        return false if guess == nil
        return false if @first_guess == @second_guess
        return false if guess.length != 2
        return false if guess[0] > @board.size || guess[1] > @board.size
        return false if @board[guess].is_face_up?
        true
    end

end

if __FILE__ == $PROGRAM_NAME
    game = Game.new(4, [Human.new("Jesse"), Computer.new])
    
    game.run
end

