require 'set'

class Node

    attr_reader :coordinates

    def initialize(x = nil, y = nil)
        @coordinates = [x, y]
    end

end

class ChessBoard
    attr_reader :board_array

    def initialize
        @board_array = []
        spaces = *(1..8)
        spaces.each do |x|
            spaces.each do |y|
                @board_array.push(Node.new(x, y))
            end
        end
    end

    def display_board
        puts "    1   2   3   4   5   6   7   8  "
        puts "  #{row_separator}"
        puts " H#{space_separator}"
        puts "  #{row_separator}"
        puts " G#{space_separator}"
        puts "  #{row_separator}"
        puts " F#{space_separator}"
        puts "  #{row_separator}"
        puts " E#{space_separator}"
        puts "  #{row_separator}"
        puts " D#{space_separator}"
        puts "  #{row_separator}"
        puts " C#{space_separator}"
        puts "  #{row_separator}"
        puts " B#{space_separator}"
        puts "  #{row_separator}"
        puts " A#{space_separator}"
        puts "  #{row_separator}"
        puts ""
    end

    private

    def space_separator
        "|   " * 8 + "|"
    end
    
    def row_separator
        "+---" * 8 + "+"
    end
end

class KnightMoves

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

    attr_reader :board_array, :shortest_path

    def initialize(start, destination)
        @start = start
        @destination = destination
    end

    def shortest_path
        queue = [[@start]]
        visited = Set.new([@start])

        until queue.empty?
            path = queue.shift
            current = path.last

            return path if current == @destination

            next_moves = generate_moves(current).reject { |move| visited.include?(move)}

            next_moves.each do |move|
                visited.add(move)
                queue << path + [move]
            end
        end

        nil #If no path found
    end

    private
    def generate_moves(coordinates)

        x, y = coordinates
        VALID_MOVES.map { |dx, dy| [x + dx, y + dy] }
                   .select { |move| valid_coordinates?(move) }
    end

    def valid_coordinates?(coordinates)
        x, y = coordinates
        x.between?(1,8) && y.between?(1,8)
    end

end

def array_fixer(array)
    array[0] = array[0].ord - 96
    array[1] = array[1].to_i
end

def convert_from_array(coordinates)
    letter = (coordinates[0] + 96).chr.upcase
    number = coordinates[1].to_s
    "#{letter}#{number}"
end

board = ChessBoard.new
board.display_board

puts "Hello! Let's get to cheating at chess. Please type your starting space (i.e. H5)"
start = gets.chomp.downcase.split('')
array_fixer(start)
until board.board_array.any? { |space| space.coordinates == start }
    puts "Nice try. Try entering some real coordinates."
    start = gets.chomp.downcase.split('')
    array_fixer(start)
end
puts "Great! Now which space would you like to get to?"
destination = gets.chomp.downcase.split('')
array_fixer(destination)
until board.board_array.any? { |space| space.coordinates == destination }
    puts "Nice try. Try entering some real coordinates."
    destination = gets.chomp.downcase.split('')
    array_fixer(destination)
end

path = KnightMoves.new(start, destination)
shortest_path = path.shortest_path

if shortest_path.nil?
    puts "No path found. Oh no."
else
    converted_path = shortest_path.map { |coord| convert_from_array(coord) } 
    puts "You can make it there in #{path.shortest_path.length - 1} moves!"
    puts "Shortest path: #{converted_path.join(' -> ')}"
end
