class Node

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

chess = Chess.new

p chess.board_array
