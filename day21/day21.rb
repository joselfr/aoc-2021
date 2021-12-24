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

  def self.gen_memo_key(positions, universes, scores=[0, 0], turn=0, dice_side=1)
    "#{dice_side}-#{turn}-#{positions * ?-}-#{scores * ?-}"
  end

  def self.propagate_universes(positions, universes={}, scores=[0, 0], turn=0, dice_side=1, wins=[0, 0])
    memo_key = gen_memo_key(positions, universes, scores, turn, dice_side)
    pp wins
    return universes[memo_key] if universes[memo_key]
    #
    # Play current universe
    #
    dice_throws = []
    while scores.max < 24
      dice_throws << [positions.clone, scores.clone, dice_side, turn]

      player_idx = turn

      positions[player_idx] += dice_side
      positions[player_idx] -= 10 while positions[player_idx] > 10
      scores[player_idx] += positions[player_idx]

      dice_side += 1
      dice_side = 1 if dice_side > 3
      turn += 1
      turn = 0 if turn > 1
    end
    wins[scores.index(scores.max)] += 1
    universes[memo_key] = wins.clone

    #
    # Play other universes
    #
    dice_throws.each do |positions, scores, dice_side, turn|
      (1..2).each do |dice_delta|
        new_dice_side = dice_side + dice_delta
        new_dice_side -= 3 if new_dice_side > 3
        propagate_universes(positions.clone, universes, scores.clone, turn, new_dice_side, universes[memo_key]) if scores.max < 24
      end
    end

    return universes[memo_key]
  end

  def self.part2
    positions = input
    pp positions
    universes = {}
    pp propagate_universes(positions, universes)
    pp universes.values.reduce { |a, b| a[0] += b[0]; a[1] += b[1]; a }
  end
end

# Day21.part2