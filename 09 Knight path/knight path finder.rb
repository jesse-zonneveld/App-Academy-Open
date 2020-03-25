require_relative "tree_node"

class KightPathFinder
    MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
].freeze


    def initialize(pos)
        @size = 8
        @start = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(@start)
        self.build_move_tree
    end

    attr_accessor :root_node

    def valid_moves(pos)
        cur_x, cur_y = pos
        new_moves = []
        MOVES.each do |(dx, dy)|
            x, y = cur_x + dx, cur_y + dy
            if x.between?(0,@size - 1) && y.between?(0, @size - 1) && !@considered_positions.include?([x, y])
                new_moves << [x, y]
                @considered_positions << [x, y]
            end
        end
        new_moves
    end

    def build_move_tree
        nodes = [@root_node]

        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            
            valid_moves(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def inspect
        @root_node.inspect
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node).map(&:value)
    end

    def trace_path_back(end_node)
        path_nodes = []
        current_node = end_node
        until current_node.nil?
            path_nodes << current_node
            current_node = current_node.parent
        end
        path_nodes.reverse
    end
end

if __FILE__ == $PROGRAM_NAME
    k = KightPathFinder.new([0,0])
    p k.find_path([5,5])
end
