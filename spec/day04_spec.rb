require_relative '../day04/day04.rb'

describe Day04 do
    it_behaves_like 'aoc_challenge_part1_example', 4512
    it_behaves_like 'aoc_challenge_part2_example', 1924
    it_behaves_like 'aoc_challenge_part1_real_input', 54275
    it_behaves_like 'aoc_challenge_part2_real_input', 13158
end