class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    attr_accessor :value
    attr_reader :parent

    def parent=(node)
        return if self.parent == node
        if self.parent
            self.parent._children.delete(self)
        end

        @parent = node
        self.parent._children << self unless self.parent.nil?
        
        self
    end

    def children
        @children.dup
    end

    def _children
        @children
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise "error not a child" if !self.children.include?(child) && child
        child.parent = nil
    end

    def dfs(target = nil, &prc)
        raise "error" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        return self if prc.call(self)

        self.children.each do |child|
            result = child.dfs(target, &prc)
            return result unless result == nil
        end
        nil
    end

    def bfs(target = nil, &prc)
        raise "Need a proc or target" if [target, prc].none?
        prc ||= Proc.new { |node| node.value == target }

        nodes = [self]

        until nodes.empty?
            node = nodes.shift
            return node if prc.call(node)
            nodes.concat(node.children)
        end
        nil
    end

end