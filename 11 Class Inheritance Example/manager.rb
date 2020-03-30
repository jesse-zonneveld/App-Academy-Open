require_relative "employee"

class Manager < Employee
    attr_reader :employees
    
    def initialize(name, salary, title, boss = nil)
        super(name, salary, title, boss)
        @employees = []
    end

    def add_employee(employee)
        self.employees << employee
    end

    def bonus(multiplier)
        sub_salaries * multiplier
    end

    def sub_salaries
        total = 0
        self.employees.each do |employee|
            if employee.is_a?(Manager)
                total += (employee.salary + employee.sub_salaries)
            else
                total += employee.salary
            end
        end
        total
    end
end