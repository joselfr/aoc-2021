require_relative '../day16/day16.rb'

describe Day16 do
    it_behaves_like 'aoc_challenge_part1_example', 31
    it_behaves_like 'aoc_challenge_part1_real_input', 945
    it_behaves_like 'aoc_challenge_part2_example', 54
    it_behaves_like 'aoc_challenge_part2_real_input', 10637009915279
end