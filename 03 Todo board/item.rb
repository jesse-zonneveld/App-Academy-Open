class Item
    def initialize(title, deadline, description)
        raise "error" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    attr_reader :deadline
    attr_accessor :title, :description

    def self.valid_date?(date)
        parts = date.split("-").map(&:to_i)
        return false if parts.length != 3
        year, month, day = parts
        return false if !(1..12).include?(month)
        return false if !(1..31).include?(day)
        true
    end

    def deadline=(new_deadline)
        raise "error" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end 

    def toggle
        @done = !@done
    end
end