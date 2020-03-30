require "colorize"

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    system("clear")
    welcome_message
    sleep(2)
    until @game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    puts "~~~~~Next player~~~~~"
    sleep(0.5)
    puts "---"
    sleep(0.5)
    puts "---"
    sleep(0.5)
    puts "---"
    sleep(2)
    puts "Memorize this sequence..."
    sleep(2)
    system("clear")
    @seq.each do |color|
      puts color
      sleep(2)
      system("clear")
      sleep(1)
    end
  end

  def require_sequence
    @seq.each do |color|
      puts "Please enter the next color in the sequence:"
      guess = gets.chomp
      if guess != color
        @game_over = true
        break
      end
      sleep(0.3)
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "Congratulations you did it!"
  end

  def game_over_message
    puts "Oh no! You made a mistake :(. You lose."
  end

  def welcome_message
    puts "~~~~~~WELCOME TO SIMON SAYS GAME~~~~~~"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if $PROGRAM_NAME == __FILE__
  game = Simon.new
  game.play
end
