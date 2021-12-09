require_relative '../day03/day03.rb'

describe Day03 do
    it_behaves_like 'aoc_challenge_part1_example', 198
    it_behaves_like 'aoc_challenge_part2_example', 230
    it_behaves_like 'aoc_challenge_part1_real_input', 3277364
    it_behaves_like 'aoc_challenge_part2_real_input', 5736383
end