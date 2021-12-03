report = File.read("input.txt").split("\n").map{_1.chars.map(&:to_i)}
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

p f[1,0,report.clone] * f[0,1,report.clone]