require_relative "00_tree_node"
class KnightPathFinder
    attr_reader :root_node
    def self.valid_moves(pos)
        x, y = pos
        result_array = []
        [-2,2].each do |i|
          [-1, 1].each do |j|
            result_array << [x+i,y+j] if KnightPathFinder.inbounds(x+i, y+j)
            result_array << [x+j,y+i] if KnightPathFinder.inbounds(x+j, y+i)
          end 
        end 
        result_array
    end 

    def self.inbounds(x, y)
        (0..7).include?(x) && (0..7).include?(y)
    end

    
    def initialize(value)
        @root_node = PolyTreeNode.new(value)
        @visited_pos = [@root_node.value]
        build_move_tree
    end 

    def find_path(pos)
       q = [@root_node]
       
       until q.empty?
        current_node = q.shift
        if current_node.value == pos
            return trace_path_back(current_node) #will return position node (goal)
        else
            current_node.children.each do |child|
                q << child
            end
        end
       end
    end 

    def trace_path_back(goal_node)
        reverse_path = []

        #debugger
        current_node = goal_node
        until current_node == @root_node
            reverse_path << current_node.value
            #debugger
            current_node = current_node.parent
        end
        #debugger
        reverse_path + [current_node.value]
    end

    def build_move_tree
        q = [@root_node]
        until q.empty?
            #debugger
            current_node = q.shift
            new_move_positions(current_node.value).each do |move|
                child = PolyTreeNode.new(move)
                child.parent = current_node
                current_node.children << child
                q << child
            end
        end 
    end 

    def new_move_positions(pos)
        result = KnightPathFinder.valid_moves(pos).reject do |position|
            @visited_pos.include?(position)
        end

        @visited_pos += result

        result
    end
end

kpf = KnightPathFinder.new([0, 0])
print kpf.find_path([6,2])

