# frozen_string_literal: true
require 'gosu'
require 'benchmark'

module Day15

  class Display < Gosu::Window
    attr_reader :is_closed

    def initialize(w, h)
      @scale = 1000/w
      super 1000, 1000
      @is_closed = false
      self.caption = "Day15 Display Window"
    end

    def set_res(map, node, visited)
      @map = map
      @visited = visited
      @node = node
    end

    def close
      @is_closed = true
    end

    def draw
      for y in 0...@visited.size
        next if @visited[y].nil?
        for x in 0...@visited[y].size
          if @visited[y][x]
            draw_rect(x * @scale, y * @scale, @scale, @scale, Gosu::Color.argb(0xFF93032E))
          end
        end
      end

      initial_node = @node
      while @node.parent != nil
        draw_rect @node.x * @scale, @node.y * @scale, @scale, @scale, Gosu::Color.argb(0xff84894A)
        @node = @node.parent
      end

      draw_rect initial_node.x * @scale, initial_node.y * @scale, @scale, @scale, Gosu::Color.argb(0xff034C3C)
    end
  end

  class Node
    attr_accessor :x, :y, :distance, :parent, :end
  end

  def self.input
    map = File.read(File.join(__dir__, 'input.txt')).split.map{_1.chars.map(&:to_i)}
    node = Node.new
    node.distance = map[0][0]
    node.x = 0
    node.y = 0
    node.end = false
    [map, [node]]
  end


  def self.print_debug(map, queue, node, visited)
    if !@window
      @window = Display.new(map.size, map[0].size)
    end
    @window.set_res(map, node, visited)
    @window.tick
    while node.end && !@window.is_closed
      @window.set_res(map, node, visited)
      @window.tick
    end
    @window = nil if @window.is_closed
  end

  def self.solve(map, queue)
    last_node = nil
    visited = []
    iterations = 0
    map_height = map.size
    map_width = map[0].size

    loop do
      node = queue.shift
      last_node = node
      if !ENV['DEBUG'].nil? && (iterations % (ENV["DEBUG_STEPS"].nil? ? 100 : ENV["DEBUG_STEPS"].to_i) == 0 || node.end)
        puts "Iteration: #{iterations}"
        print_debug(map, queue, node, visited)
      end
      break if node.end
      visited[node.y] ||= {}
      visited[node.y][node.x] = true

      y = node.y
      x = node.x

      for dy, dx in [[0, 1], [0, -1], [1, 0] ,[-1, 0]]
        nny = y + dy
        nnx = x + dx
        if nny >= 0 && nny < map_height && nnx >= 0 && nnx < map_width
          next if visited.dig(nny, nnx)
          neighbour_node = queue.find{|n| n.x == nnx && n.y == nny}

          if !neighbour_node
            neighbour_node = Node.new
            neighbour_node.distance = node.distance + map[nny][nnx]
            neighbour_node.parent = node
            neighbour_node.end = nny == map.size-1 && nnx == map[nny].size-1
            neighbour_node.x = nnx
            neighbour_node.y = nny
            queue << neighbour_node
          elsif neighbour_node && neighbour_node.distance > node.distance + map[nny][nnx]
            neighbour_node.distance = node.distance + map[nny][nnx]
            neighbour_node.parent = node
          end
        end
      end

      queue.sort_by!(&:distance)
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
    new_map = []

    for y in 0...map.length*5
      new_map[y] = []
      for x in 0...map[0].length*5
        new_map[y][x] = map[y%map.length][x % map[0].length] + y / map.length + x / map[0].length
        new_map[y][x] = new_map[y][x] % 9 if new_map[y][x] > 9
      end
    end

    solve(new_map, queue)
  end
end