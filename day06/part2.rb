f = File.read("input.txt").split(',').map(&:to_i).tally

256.times {
    new_fish = (f[0] || 0)
    (0..7).each do |idx|
        f[idx] = f[idx + 1]
    end
    f[6] = (f[6] || 0) + new_fish
    f[8] = new_fish
    p "Day #{_1 + 1} #{f}"
}

p f.sum{_2}