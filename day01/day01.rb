# frozen_string_literal: true

module Day01
  def self.input
    File.read(File.join(__dir__, 'input.txt')).split.map(&:to_i)
  end

  def self.part1
    input.each_cons(2).count { |a, b| a < b }
  end

  def self.part2
    input.each_cons(3).each_cons(2).count { |a, b| a.sum < b.sum }
  end
end