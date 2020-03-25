require "item.rb"

class List
    # print styles
    LINE_WIDTH = 42
    INDEX_COL_WIDTH = 5
    ITEM_COL_WIDTH = 20
    DEADLINE_COL_WIDTH = 10

    def initialize(label)
        @label = label
        @items = []
    end

    attr_accessor :label

    def add_item(title, deadline, description = "")
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description = "")
        true
    end

    def size
        @items.length
    end

    def valid_index?(i)
        (0...self.size).include?(i)
    end

    def swap(i1, i2)
        return false if !self.valid_index?(i1) || !self.valid_index?(i2)
        @items[i1], @items[i2] = @items[i2], @items[i1]
        true
    end

    def [](i)
        return nil if !self.index?(i)
        @items[i]
    end

    def priority
        self[0]
    end

    def print
        puts "-" * LINE_WIDTH
        puts " " * 16 + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{'Index'.ljust(INDEX_COL_WIDTH)} | #{'Item'.ljust(ITEM_COL_WIDTH)} | #{'Deadline'.ljust(DEADLINE_COL_WIDTH)}"
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)}"
        end
        puts "-" * LINE_WIDTH
    end

    def print_full_item(i)
        item = self[i]
        return if !self.valid_index?(i)
        puts "-" * LINE_WIDTH
        puts "#{item.title.ljust(LINE_WIDTH/2)}  #{item.deadline.rjust(LINE_WIDTH/2)}"
        puts "#{item.description}"
        puts "-" * LINE_WIDTH
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, num = 1)
        return false if !self.valid_index?(index)
        while num > 0 && index != 0
            @items.swap(index, index - 1)
            i -= 1
            num -= 1
            end
        end
        true
    end

    def down(index, num = 1)
        return false if !self.valid_index?(index)
        while num > 0 && index != self.size
            @items.swap(index, index + 1)
            i += 1
            num -= 1
            end
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(i)
        self[i].toggle
    end

end