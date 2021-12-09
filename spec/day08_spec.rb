require_relative '../day08/day08.rb'

describe Day08 do
    it_behaves_like 'aoc_challenge_part1_example', 26
    it_behaves_like 'aoc_challenge_part2_example', 61229
    it_behaves_like 'aoc_challenge_part1_real_input', 272
    it_behaves_like 'aoc_challenge_part2_real_input', 1007675
end