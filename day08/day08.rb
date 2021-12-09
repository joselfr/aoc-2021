# frozen_string_literal: true

module Day08
  def self.input
    input = File.read('input.txt').split("\n").map { _1.split('|').map(&:split) }
  end

  def self.part1
    r = input.map { _2 }.flatten.map do
      case _1.size
      when 2
        1
      when 4
        4
      when 3
        7
      when 7
        8
      else
        0
      end
    end

    r.size - r.count(0)
  end

  def self.part2
    inputs = input
    outputs = []
    inputs.each do |input, output|
      input = input.map(&:chars)
      output = output.map(&:chars)

      input_mapping = []
      input_mapping[1] = input.find { _1.size == 2 }.sort
      input_mapping[4] = input.find { _1.size == 4 }.sort
      input_mapping[7] = input.find { _1.size == 3 }.sort
      input_mapping[8] = input.find { _1.size == 7 }.sort

      segment_mapping = { a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil }
      segment_mapping[:a] = (input_mapping[7] - input_mapping[1])[0]
      segment_mapping[:g] = input.map do |i|
                              (i - [segment_mapping[:a]] - input_mapping[4])
                            end.find { _1.size == 1 }[0]
      segment_mapping[:e] = input.map do |i|
                              (i - [segment_mapping[:a], segment_mapping[:g]] - input_mapping[4])
                            end.find { _1.size == 1 }[0]
      segment_mapping[:d] = input.map do |i|
                              (i - [segment_mapping[:a], segment_mapping[:g]] - input_mapping[1])
                            end.find { _1.size == 1 }[0]
      segment_mapping[:b] = input.map do |i|
                              (i - [segment_mapping[:g], segment_mapping[:e], segment_mapping[:d]] - input_mapping[7])
                            end.find { _1.size == 1 }[0]
      segment_mapping[:f] = input.flatten.tally.find { _2 == 9 }[0]
      segment_mapping[:c] = (%w[a b c d e f g] - segment_mapping.values)[0]

      input_mapping[0] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:b],
              segment_mapping[:c],
              segment_mapping[:e],
              segment_mapping[:f],
              segment_mapping[:g]]).size.zero? && i.size == 6
      end.sort

      input_mapping[2] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:d],
              segment_mapping[:c],
              segment_mapping[:e],
              segment_mapping[:g]]).size.zero? && i.size == 5
      end.sort

      input_mapping[3] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:c],
              segment_mapping[:d],
              segment_mapping[:f],
              segment_mapping[:g]]).size.zero? && i.size == 5
      end.sort

      input_mapping[5] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:b],
              segment_mapping[:d],
              segment_mapping[:f],
              segment_mapping[:g]]).size.zero? && i.size == 5
      end.sort

      input_mapping[6] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:b],
              segment_mapping[:d],
              segment_mapping[:e],
              segment_mapping[:f],
              segment_mapping[:g]]).size.zero? && i.size == 6
      end.sort

      input_mapping[9] = input.find do |i|
        (i - [segment_mapping[:a],
              segment_mapping[:b],
              segment_mapping[:c],
              segment_mapping[:d],
              segment_mapping[:f],
              segment_mapping[:g]]).size.zero? && i.size == 6
      end.sort
      outputs << (output.map { input_mapping.index(_1.sort) } * '').to_i
    end

    outputs.sum
  end
end

puts Day08.part1
puts Day08.part2
