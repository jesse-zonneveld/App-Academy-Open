class HanoiGame
    attr_reader :towers
    def initialize
        @towers = [[3, 2, 1], [], []]
    end

    def play
        while !won?
            begin
                display
                puts "Move from where?"
                from_tower = gets.chomp.to_i
                puts "Move to where?"
                to_tower = gets.chomp.to_i
                if valid_move?(from_tower, to_tower)
                    move(from_tower, to_tower)
                else
                    puts "Sorry, invalid move"
                    puts "Try again..."
                    sleep(2)
                end
            rescue => e
                puts e.message
                sleep(2)
                retry
            end
        end
        puts "you win :)"
    end

    def move(from_tower, to_tower)
        raise "cannot move an empty tower" if towers[from_tower].empty?
        if !towers[to_tower].empty?
            raise "cannot move onto smaller disc" if towers[from_tower].last > towers[to_tower].last
        end

        towers[to_tower] << towers[from_tower].pop
    end

    def won?
        towers.last == [3, 2, 1]
    end

    def valid_move?(from_tower, to_tower)
        [from_tower, to_tower].all? { |p| p.between?(0, 2) }
    end

    def display
        system("clear")
        3.times do |i|
            puts "Tower #{i}: #{towers[i]}"
        end
    end
end

if $PROGRAM_NAME == __FILE__
    g = HanoiGame.new.play
end