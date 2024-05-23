require './graph'

class KnightTravails
  TRANSFORMATIONS = [
    [1, 2], [2, 1], [1, -2], [2, -1],
    [-2, -1], [-1, -2], [-1, 2], [-2, 1]
  ].freeze

  BOARD_SIZE = 8

  def initialize
    @board = Graph.new
    build_board
  end

  def build_board
    BOARD_SIZE.times do |i|
      BOARD_SIZE.times do |j|
        TRANSFORMATIONS.each do |dx, dy|
          x = i + dx
          y = j + dy
          @board.add_neighbour([i, j], [x, y]) if valid?(x, y)
        end
      end
    end
  end

  def valid?(x_pos, y_pos)
    x_pos.between?(0, BOARD_SIZE - 1) && y_pos.between?(0, BOARD_SIZE - 1)
  end

  def knights_tour(start, goal)
    path = @board.shortest_path(start, goal)
    if path
      puts "Shortest path from #{start} to #{goal}:"
      path.each { |pos| p pos }
    else
      puts "No path found from #{start} to #{goal}" # should never be reached
    end
  end

  # for fun
  def knights_reach(start)
    reachable_nodes = []
    @board.level_order([0, 0]) { |node| reachable_nodes << node.key }
    puts "Reachable nodes from #{start}: #{reachable_nodes}"
  end
end

kt = KnightTravails.new
kt.knights_tour([7, 5], [1, 0])
