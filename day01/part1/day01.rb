nbs = File.read("input.txt").split.map(&:to_i)
puts print nbs.each_cons(2).count { |a,b| a<b }