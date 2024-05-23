class Node
  attr_accessor :key, :links

  def initialize(key)
    @key = key
    @links = []
  end

  def add_link(node)
    @links << node unless @links.include?(node)
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_node(key)
    @nodes[key] ||= Node.new(key)
  end

  def add_neighbour(from_key, to_key)
    from_node = add_node(from_key)
    to_node = add_node(to_key)
    from_node.add_link(to_node)
  end

  def find_node(key)
    @nodes[key]
  end

  def level_order(start_key)
    start_node = find_node(start_key)
    return nil unless start_node

    queue = [start_node]
    visited = { start_node => nil }

    until queue.empty?
      current = queue.shift
      yield(current, visited) if block_given?
      current.links.each do |neighbor|
        next if visited.key?(neighbor)

        queue << neighbor
        visited[neighbor] = current
      end
    end
    visited
  end

  def shortest_path(start_key, goal_key)
    visited = level_order(start_key)
    return nil unless visited

    start_node = find_node(start_key)
    goal_node = find_node(goal_key)
    return nil unless start_node && goal_node

    path = []
    current = goal_node
    while current != start_node
      path.unshift(current.key)
      current = visited[current]
    end
    path.unshift(start_node.key)
    path
  end
end
