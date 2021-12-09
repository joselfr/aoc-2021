require_relative '../day02/day02'

describe Day02 do
    it_behaves_like 'aoc_challenge_part1_example', 150
    it_behaves_like 'aoc_challenge_part2_example', 900
    it_behaves_like 'aoc_challenge_part1_real_input', 1714680
    it_behaves_like 'aoc_challenge_part2_real_input', 1963088820
end