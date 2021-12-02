orders = File.read('input.txt').split("\n").map { |line| line.split.tap { |a,b| break {order: a, arg: b.to_i} } }
hpos = 0
depth = 0
orders.each do |order|
    case order[:order]
    when 'up'
        depth = [depth - order[:arg], 0].max
    when 'down'
        depth += order[:arg]
    when 'forward'
        hpos += order[:arg]
    end
end

puts hpos * depth