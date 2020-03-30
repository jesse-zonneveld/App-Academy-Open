require_relative "manager"

class Employee
    def initialize(name, title, salary, boss = nil)
        @name, @title, @salary = name, title, salary
        self.boss = boss
    end

    attr_reader :name, :title, :salary
    attr_accessor :boss

    def boss=(boss)
        @boss = boss
        boss.add_employee(self) unless boss.nil?
    end

    def bonus(multiplier)
        self.salary * multiplier
    end

end