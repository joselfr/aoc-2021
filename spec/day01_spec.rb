require_relative '../day01/day01'

describe Day01 do
    it_behaves_like 'aoc_challenge_part1_example', 7
    it_behaves_like 'aoc_challenge_part2_example', 5
    it_behaves_like 'aoc_challenge_part1_real_input', 1121
    it_behaves_like 'aoc_challenge_part2_real_input', 1065
end