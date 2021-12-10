# frozen_string_literal: true

module Day10
  
  MAPPING_VALUE_P1 = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  MAPPING_VALUE_P2 = {
    "(" => 1,
    "[" => 2,
    "{" => 3,
    "<" => 4
  }

  def self.input
    File.read(File.join(__dir__, 'input.txt')).split(?\n).map(&:chars)
  end
  
  def self.is_valid?(row)
    stack = []
    row.each do |c|
      if c.match(/[\(\[\{\<]/)
        stack << c
      else
        last_in_stack = stack.pop
        if (last_in_stack.ord - c.ord).abs > 2
          return c
        end
      end
    end
    nil
  end

  def self.part1
    illegal_chars = []
    input.each do |row|
      illegal_char = is_valid?(row)
      illegal_chars << illegal_char if illegal_char
    end
    illegal_chars.sum{|c| MAPPING_VALUE_P1[c]}
  end
  
  def self.part2
    incomplete = input.filter{ |row| is_valid?(row).nil? }
    scores = incomplete.map do |row|
      stack = []
      row.each do |c|
        if c.match(/[\(\[\{\<]/)
          stack << c
        else
          stack.pop
        end
      end
      missing = stack.reverse
      missing.reduce(0) { |score, c| (score * 5) + MAPPING_VALUE_P2[c] }
    end

    scores.sort[scores.size / 2]
  end
end