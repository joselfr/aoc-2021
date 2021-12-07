pos = File.read("input.txt")
# pos = "16,1,2,0,4,2,7,1,2,14"
pos = pos.split(?,).map(&:to_i)

usage = (0..pos.max).map { |p|
    puts "Moving to #{p} (#{pos.count(p)}):"
    u = pos.sum{n=(_1-p).abs; (n*(n+1))/2}
    p u
    u
}.min

p usage