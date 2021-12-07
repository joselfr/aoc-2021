pos = File.read("input.txt")
pos = pos.split(?,).map(&:to_i)

usage = pos.uniq.map { |p|
    puts "Moving to #{p} (#{pos.count(p)}):"
    u = pos.sum{(_1-p).abs}
    p u
    u
}.min

p usage