# frozen_string_literal: true

module Day14
  def self.input
    file = File.open(File.join(__dir__, 'input.txt'))
    polymer = file.gets.chomp.chars
    pairs = Hash[file.read.strip.split("\n").map { |line| line.split(' -> ') }]
    file.close
    [polymer, pairs]
  end

  def self.solve(steps)
    polymer, pairs = input
    each_count = polymer.tally
    consecutives = polymer.each_cons(2).tally

    steps.times do
      new_consecutives = {}
      consecutives.each do |c, v|
        key = c.join
        new_consecutives[[c[0], pairs[key]]] ||= 0
        new_consecutives[[pairs[key], c[1]]] ||= 0
        new_consecutives[[c[0], pairs[key]]] += v
        new_consecutives[[pairs[key], c[1]]] += v

        each_count[pairs[key]] ||= 0
        each_count[pairs[key]] += v
      end
      consecutives = new_consecutives
    end
    each_count.values.max - each_count.values.min
  end

  def self.part1
    solve(10)
  end
  
  def self.part2
    solve(40)
  end
end