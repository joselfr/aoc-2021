# frozen_string_literal: true

module Day06
  def self.input
    File.read('input.txt').split(',').map(&:to_i)
  end

  def self.part1
    f = input

    80.times do
      to_add = []
      f.each_with_index do |fish, idx|
        if fish.zero?
          f[idx] = 6
          to_add << 8
        else
          f[idx] -= 1
        end
      end
      f += to_add
    end
    f.size
  end

  def self.part2
    f = input.tally

    256.times do
      new_fish = (f[0] || 0)
      (0..7).each do |idx|
        f[idx] = f[idx + 1]
      end
      f[6] = (f[6] || 0) + new_fish
      f[8] = new_fish
    end

    f.sum { _2 }
  end
end

puts Day06.part1
puts Day06.part2
