class Node

    attr_reader :coordinates

    def initialize(x = nil, y = nil)
        @coordinates = [x, y]
    end

end

class Chess

    attr_reader :board_array

    def initialize
        @board_array = []
        spaces = *(1..8)
        spaces.each do |x|
            spaces.each do |y|
                board_array.push(Node.new(x, y))
            end
        end
    end

end

class Knight
    
    attr_reader :start, :destination

    VALID_MOVES = [
        [1, 2],
        [1, -2],
        [-1, 2],
        [-1, -2],
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1]
    ]

    def initialize(start, destination)
        @start = start
        @destination = destination
    end

    def is_legal?()

end


