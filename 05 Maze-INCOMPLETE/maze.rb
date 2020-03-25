class Maze
    def initialize(file)
        @maze = load_file(file)
        @open_list = []
    end

    def load_file(file)
        maze = []
        File.open(file).each_line do |line|
            row = line.chomp.split("")
            maze << row
        end
        maze
    end

    def find_char(char)
        @maze.each_with_index do |row, row_i|
            return[row_i, row.index(char)] if row.include?(char)
        end
        return "couldn't find that character."
    end
    
end


if __FILE__ == $PROGRAM_NAME
    maze = Maze.new("maze1.txt")
    p maze
    puts maze.find_char("f")
end