require "set"
require "./Player.rb"

class Game
    ALPHA = ("a".."z").to_a
    def initialize(*players)
        words = File.readlines("dictionary.txt").map(&:chomp)
        @players = players
        @dictionary = Set.new(words)
        @losses = {}

        @players.each { |player| @losses[player] = 0 }
    end

    attr_reader :players, :current_player, :losses

    
#Core gameplay
    def run
        self.play_round until self.game_over?
        p "The winner is #{@player[0]}"
    end

    def play_round
        @fragment = ""
        self.welcome
        sleep(2)

        while !self.round_over?
            self.take_turn(self.current_player)
            sleep(1)
            puts "-----------------------"
            self.next_player!
        end

        self.update_score
        sleep(1)
    end

    def take_turn(player)
        puts "#{self.current_player.name} please enter a letter: "
        letter = self.gets_letter
        @fragment += letter
        sleep(1)
        puts "The current word fragment is now: #{@fragment}"
    end


#Helper methods
    def game_over?
        return true if @players.length == 1
        false
    end

    def round_over?
        @dictionary.include?(@fragment)
    end

    def current_player
        @players.first
    end

    def previous_player
        @players[1]
    end

    def next_player!
        @players.rotate!
    end

    def gets_letter
        letter = gets.chomp.downcase
        while !ALPHA.include?(letter) || !@dictionary.any? { |word| word.start_with?(@fragment + letter) }
            puts "please enter valid letter"
            letter = gets.chomp.downcase
        end
        letter
    end

    def welcome
        system("clear")
        puts "-----New round begins-----"
        puts "remaining players: "
        self.display_standings
        sleep(1)
        puts "--------------------------"
        puts
    end

    def display_standings
        @losses.each do |player, value|
            sleep(1)
            puts "#{player.name} has #{value} losses"
        end
    end

    def update_score
        system("clear")
        puts "#{self.previous_player.name} spelled the word #{@fragment}"
        sleep(3)
        @losses[self.previous_player] += 1
        puts "#{self.previous_player.name} now has #{@losses[self.previous_player]} losses"
        sleep(3)
        if losses[self.previous_player] == 5 
            sleep(2)
            puts "#{self.previous_player.name} has been eliminated"
            @players.delete(self.previous_player)
        end

    end



    

end

if $PROGRAM_NAME == __FILE__
  game = Game.new(
    Player.new("Means Beans"), 
    Player.new("Jells Bells")
    )
  game.run

end

        