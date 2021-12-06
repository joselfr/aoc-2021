f = File.read("input.txt").split(',').map(&:to_i)
# f = [3,4,3,1,2]

80.times {
    to_add = []
    
    f.each_with_index do |fish, idx|
        if fish == 0
            f[idx] = 6
            to_add << 8
        else
            f[idx] -= 1
        end
    end
    
    f += to_add
    p "Day #{_1 + 1} #{f}"
}

p f.size