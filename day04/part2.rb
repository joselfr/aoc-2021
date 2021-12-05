require 'pp'

bingo = File.open("input.txt")
draw = bingo.gets.split(',').map(&:to_i)
boards = bingo.read.split.map(&:to_i).each_slice(5).each_slice(5).to_a

draw.each do |drawn_number|
    to_delete = []
    boards.each do |board|
        board.each do |line|
            if line.include?(drawn_number)
                bing_index = line.index(drawn_number)
                line[bing_index] = 'X'
                if line.count('X') == 5 || board.map{_1[bing_index]}.count('X') == 5
                    puts "BINGO! #{board.flatten.filter{_1!='X'}.sum * drawn_number}"
                    to_delete << board
                end
            end
        end
    end
    boards.delete_if{to_delete.include?(_1)}
end