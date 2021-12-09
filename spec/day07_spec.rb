require_relative '../day07/day07.rb'

describe Day07 do
    it_behaves_like 'aoc_challenge_part1_example', 37
    it_behaves_like 'aoc_challenge_part2_example', 168
    it_behaves_like 'aoc_challenge_part1_real_input', 357353
    it_behaves_like 'aoc_challenge_part2_real_input', 104822130
end