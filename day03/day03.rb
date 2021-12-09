module Day03
    def self.input
        File.read(File.join(__dir__, "input.txt")).split("\n").map{_1.chars.map(&:to_i)}
    end

    def self.part1
        gamma = input.pop.zip(*input).map{|row| (row.count(1)>row.count(0)) ? 1 : 0}.join
        epsilon = gamma.tr('01', '10')

        gamma.to_i(2) * epsilon.to_i(2)
    end

    def self.part2
        idx = 0
        f= ->(a,b,report) {
            loop do
                report_bits = report.first.zip(*report[1..])
                most_present_bit_value = report_bits[idx].count(1) >= report_bits[idx].count(0) ? a : b
                report.select!{_1[idx] == most_present_bit_value}
                idx = (idx + 1) % report[0].size
                break if report.size == 1
            end
            report.first.join.to_i(2)
        }
        
        f[1,0,input.clone] * f[0,1,input.clone]
    end
end