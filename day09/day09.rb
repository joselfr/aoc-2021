# frozen_string_literal: true

module Day09
  def self.input
    File.read('input.txt').split.map { _1.chars.map(&:to_i) }
  end

  def self.search_lowerpoint(map)
    (0...map.size).each do |y|
      (0...map[y].size).each do |x|
        adjacent = []
        adjacent << map[y][x - 1] if x - 1 >= 0
        adjacent << map[y][x + 1] if x + 1 < map[y].size
        adjacent << map[y - 1][x] if y - 1 >= 0
        adjacent << map[y + 1][x] if y + 1 < map.size

        yield(y, x) if map[y][x] < adjacent.min
      end
    end
  end

  def self.part1
    map = input
    risk_level = 0
    search_lowerpoint(map) { |y, x| risk_level += map[y][x] + 1 }
    risk_level
  end

  def self.check_basin(map, y, x, visited = nil)
    return 0 if map[y][x] == 9 || (!visited.nil? && visited.dig(y, x) == true)

    visited ||= []
    visited[y] ||= []
    visited[y][x] = true
    basin_size = 1
    basin_size += check_basin(map, y, x - 1, visited) if x - 1 >= 0
    basin_size += check_basin(map, y, x + 1, visited) if x + 1 < map[y].size
    basin_size += check_basin(map, y - 1, x, visited) if y - 1 >= 0
    basin_size += check_basin(map, y + 1, x, visited) if y + 1 < map.size
    basin_size
  end

  def self.part2
    map = input
    basin_sizes = []
    search_lowerpoint(map) { |y, x| basin_sizes << check_basin(map, y, x) }
    basin_sizes.sort.pop(3).reduce(:*)
  end
end

puts Day09.part1
puts Day09.part2
