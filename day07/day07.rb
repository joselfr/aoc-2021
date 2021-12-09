# frozen_string_literal: true

module Day07
  def self.input
    File.read(File.join(__dir__, 'input.txt')).split(',').map(&:to_i)
  end

  def self.solve(&block)
    (input.min..input.max).map(&block).min
  end

  def self.part1
    solve { |p| input.sum { (_1 - p).abs } }
  end

  def self.part2
    solve do |p|
      input.sum do
        n = (_1 - p).abs
        (n * (n + 1)) / 2
      end
    end
  end
end