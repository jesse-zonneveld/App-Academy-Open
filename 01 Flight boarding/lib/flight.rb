class Flight
    def initialize(str, capacity)
        @flight_number = str
        @capacity = capacity
        @passengers = []
    end

    attr_reader :passengers

    def full?
        @passengers.length == @capacity
    end 

    def board_passenger(passenger)
        if passenger.has_flight?(@flight_number) && !self.full?
            @passengers << passenger
        end
    end

    def list_passengers
        @passengers.map(&:name)
    end

    def [](i)
        @passengers[i]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end

end