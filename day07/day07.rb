module Day07
    def self.input
        @input ||= File.read("input.txt").split(?,).map(&:to_i)
    end
    
    def self.solve(&block)
        (input.min..input.max).map(&block).min
    end

    def self.part1
        solve { |p| input.sum{(_1-p).abs} }
    end 
    
    def self.part2 
        solve { |p| input.sum{n=(_1-p).abs; (n*(n+1))/2} } 
    end 
end

puts Day07.part1
puts Day07.part2