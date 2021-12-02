orders = File.read('input.txt').split("\n").map { |line| line.split.tap { |a,b| break {order: a, arg: b.to_i} } }
hpos = 0
depth = 0
aim = 0
orders.each do |order|
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

puts hpos * depth