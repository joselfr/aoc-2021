require_relative '../day09/day09.rb'

describe Day09 do
    it_behaves_like 'aoc_challenge_part1_example', 15
    it_behaves_like 'aoc_challenge_part2_example', 1134
    it_behaves_like 'aoc_challenge_part1_real_input', 528
    it_behaves_like 'aoc_challenge_part2_real_input', 920448
end