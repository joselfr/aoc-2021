# frozen_string_literal: true

module Day11
  def self.input
    File.read(File.join(__dir__, 'input.txt')).split(?\n).map{ |r| r.chars.map(&:to_i) }
  end

  def self.step(grid)
    flashes = 0
    grid.map! { |row| row.map { |v| v + 1 } }
    changes = true
    while changes
      changes = false
      for y in (0...grid.size)
        for x in (0...grid[y].size)
          if grid[y][x] > 9
            grid[y][x] = 0
            flashes += 1
            for dy in (-1..1)
              for dx in (-1..1)
                next if dy == 0 && dx == 0
                nx = x + dx
                ny = y + dy
                grid[ny][nx] += 1 if nx >= 0 && nx < grid[y].size && ny >= 0 && ny < grid[y].size && grid[ny][nx] != 0
              end
            end
            changes = true
          end
        end
      end
    end
    flashes
  end
  
  def self.part1
    grid = input
    flashes = 0

    100.times do
      flashes += step(grid)
    end
    flashes
  end
  
  def self.part2
    i = 1
    grid = input
    i += 1 while step(grid) != 100
    i
  end
end