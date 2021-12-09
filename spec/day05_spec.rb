require_relative '../day05/day05.rb'

describe Day05 do
    it_behaves_like 'aoc_challenge_part1_example', 5
    it_behaves_like 'aoc_challenge_part2_example', 12
    it_behaves_like 'aoc_challenge_part1_real_input', 5197
    it_behaves_like 'aoc_challenge_part2_real_input', 18605
end