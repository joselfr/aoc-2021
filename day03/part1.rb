report = File.read("input.txt").split("\n").map{_1.chars.map(&:to_i)}
gamma = report.pop.zip(*report).map{|row| (row.count(1)>row.count(0)) ? 1 : 0}.join
epsilon = gamma.tr('01', '10')

p gamma.to_i(2) * epsilon.to_i(2)