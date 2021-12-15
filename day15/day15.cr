# frozen_string_literal: true
module Day15
  class Node
    property x : Int32
    property y : Int32
    property distance : Int32
    property parent : Node | Nil
    property last : Bool

    def initialize
      @x = 0
      @y = 0
      @distance = Int32::MAX
      @last = false
    end
  end

  def self.input
    map = File.read(File.join(__DIR__, "input.txt")).split.map(&.chars.map(&.to_i))
    node = Node.new
    node.distance = map[0][0]
    node.x = 0
    node.y = 0
    node.last = false
    return map, [node]
  end


  def self.solve(map, queue)
    last_node = queue.first
    iterations = 0
    map_height = map.size
    map_width = map_height
    visited = Array.new(map_height) { Array.new(map_width, false) }

    loop do
      node = queue.shift
      last_node = node
      break if node.last

      visited[node.y] ||= [] of Bool
      visited[node.y][node.x] = true

      y = node.y
      x = node.x

      [[0, 1], [0, -1], [1, 0] ,[-1, 0]].each do |deltas|
        nny = y + deltas[0]
        nnx = x + deltas[1]
        if nny >= 0 && nny < map_height && nnx >= 0 && nnx < map_width
          next if visited.dig(nny, nnx)
          neighbour_node = queue.find{|n| n.x == nnx && n.y == nny}

          if !neighbour_node
            neighbour_node = Node.new
            neighbour_node.distance = node.distance + map[nny][nnx]
            neighbour_node.parent = node
            neighbour_node.last = nny == map.size-1 && nnx == map[nny].size-1
            neighbour_node.x = nnx
            neighbour_node.y = nny
            queue << neighbour_node
          elsif neighbour_node && neighbour_node.distance > node.distance + map[nny][nnx]
            neighbour_node.distance = node.distance + map[nny][nnx]
            neighbour_node.parent = node
          end
        end
      end

      queue.sort_by!(&.distance)
      iterations += 1
    end
    last_node.distance - map[0][0]
  end

  def self.part1
    map, queue = input
    solve(map, queue)
  end

  def self.part2
    map, queue = input
    new_map = Array.new(map.size * 5) { Array.new(map.size * 5, 0) }

    (0...(map.size*5)).each do |y|
      (0...(map.size*5)).each do |x|
        new_map[y][x] = map[y % map.size][x % map.size] + (y / map.size).to_i + (x / map.size).to_i
        new_map[y][x] = new_map[y][x] % 9 if new_map[y][x] > 9
      end
    end

    solve(new_map, queue)
  end
end

puts Day15.part1
puts Day15.part2