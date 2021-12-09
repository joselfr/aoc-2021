# frozen_string_literal: true

module Day04
  def self.input
    bingo = File.open('input.txt')
    draw = bingo.gets.split(',').map(&:to_i)
    boards = bingo.read.split.map(&:to_i).each_slice(5).each_slice(5).to_a
    [draw, boards]
  end

  def self.part1
    draw, boards = input
    draw.each do |drawn_number|
      boards.each do |board|
        board.each do |line|
          next unless line.include?(drawn_number)

          bing_index = line.index(drawn_number)
          line[bing_index] = 'X'
          if line.count('X') == 5 || board.map { _1[bing_index] }.count('X') == 5
            return board.flatten.filter { _1 != 'X' }.sum * drawn_number
          end
        end
      end
    end
  end

  def self.part2
    draw, boards = input
    last_bingo = 0
    draw.each do |drawn_number|
      to_delete = []
      boards.each do |board|
        board.each do |line|
          next unless line.include?(drawn_number)

          bing_index = line.index(drawn_number)
          line[bing_index] = 'X'
          if line.count('X') == 5 || board.map { _1[bing_index] }.count('X') == 5
            last_bingo = board.flatten.filter { _1 != 'X' }.sum * drawn_number
            to_delete << board
          end
        end
      end
      boards.delete_if { to_delete.include?(_1) }
    end
    last_bingo
  end
end

puts Day04.part1
puts Day04.part2
