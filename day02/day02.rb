module Day02
    def self.input
        File.read(File.join(__dir__, "input.txt")).split("\n").map { |line| line.split.tap { |a,b| break {order: a, arg: b.to_i} } }
    end

    def self.part1
        hpos = 0
        depth = 0
        input.each do |order|
            case order[:order]
            when 'up'
                depth = [depth - order[:arg], 0].max
            when 'down'
                depth += order[:arg]
            when 'forward'
                hpos += order[:arg]
            end
        end

        hpos * depth
    end
    
    def self.part2
        hpos = 0
        depth = 0
        aim = 0
        input.each do |order|
            case order[:order]
            when 'up'
                aim -= order[:arg]
            when 'down'
                aim += order[:arg]
            when 'forward'
                hpos += order[:arg]
                depth = [depth + aim * order[:arg], 0].max
            end
        end
        
        hpos * depth
    end
end

puts Day02.part1
puts Day02.part2