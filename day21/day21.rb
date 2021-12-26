# frozen_string_literal: true

module Day21
  def self.input
    File.read(File.join(__dir__, 'input.txt')).split("\n").map { |line| line.split(' ').last.to_i }
  end

  def self.part1
    positions = input
    scores = [0, 0]
    dice_side = 1
    turn = 0
    while scores.max < 1000
      player_idx = turn % 2
      dice_value = dice_side + dice_side + 1 + dice_side + 2

      positions[player_idx] += dice_value
      positions[player_idx] -= 10 while positions[player_idx] > 10
      scores[player_idx] += positions[player_idx]

      dice_side += 3
      turn += 1
    end

    scores.min * (dice_side - 1)
  end

  def self.gen_memo_key(positions, scores=[0, 0], turn=0)
    "#{turn}-#{positions * ?-}-#{scores * ?-}"
  end

  def self.play_universe(positions, scores=[0,0], turn=0, memo={})
    memo_key = gen_memo_key(positions, scores, turn)
    if memo[memo_key]
      return memo[memo_key]
    end
    wins = [0, 0]
    if scores.max >= 21
      wins[scores.index(scores.max)] = 1
      return wins
    end

    possible_dice_rolls = [1,2,3].product([1,2,3], [1,2,3])
    possible_dice_rolls.each do |dice_rolls|
      new_scores = scores.clone
      new_positions = positions.clone

      new_positions[turn] += dice_rolls.sum
      new_positions[turn] -= 10 while new_positions[turn] > 10
      new_scores[turn] += new_positions[turn]
      pwins = play_universe(new_positions, new_scores, (turn + 1) % 2, memo)
      wins[0] += pwins[0]
      wins[1] += pwins[1]
    end

    memo[memo_key] = wins.clone
    return wins
  end

  def self.part2
    positions = input
    play_universe(positions).max
  end
end