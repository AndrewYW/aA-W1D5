require 'byebug'
class PolyTreeNode

    attr_reader :value, :children
    attr_accessor :parent
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)

        unless @parent.nil?
            @parent.children.delete(self)
        end

        if node
            @parent = node
            node.children << self unless node.children.include?(self)
        else
            @parent = nil
        end

    end

    def add_child(child_node)
       @children << child_node 
       child_node.parent = self
    end

    def remove_child(child_node)
        raise "error" unless @children.include?(child_node)
        @children.delete(child_node)
        child_node.parent = nil
    end

    def dfs( target)
        if self.value == target
            return self
        else
            self.children.each do |child|
                #debugger
                result = child.dfs(target)
                return result unless result.nil?     
            end
            return nil
        end
    end

    def bfs(target)
        q = [self]

        until q.empty?
            current_node = q.shift
            if  current_node.value == target
                return current_node
            else
                #current_node.children = new_move_pos
                current_node.children.each do |child|
                    q << child
                end
            end
        end
    end
end
