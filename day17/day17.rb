# frozen_string_literal: true
require 'matrix'

class Vector
  def x
    self[0]
  end

  def y
    self[1]
  end

  def x=(v)
    self[0] = v
  end

  def y=(v)
    self[1] = v
  end
end

module Day17

  def self.input
    File.read(File.join(__dir__, 'input.txt')).scan(/(\-?\d+)..(\-?\d+)/).map { |a, b| (a.to_i..b.to_i) }
  end

  def self.solve
    xrange, yrange = input
    good_vels = []
    maxy = 0

    (0..xrange.max).to_a.product((yrange.min..(yrange.min * -1)).to_a).each do |xvel, yvel|
      pos = Vector[0,0]
      vel = Vector[xvel, yvel]
      init_vel = vel.clone
      step_maxy = 0
      loop do
        pos += vel

        step_maxy = pos.y if pos.y > step_maxy
        if xrange.cover?(pos.x) && yrange.cover?(pos.y)
          good_vels << init_vel
          maxy = step_maxy if step_maxy > maxy
          break
        end

        vel.x -= 1 if vel.x != 0
        vel.y -= 1
        break if pos.x > xrange.max || pos.y < yrange.min
      end
    end
    return maxy, good_vels.count
  end

  def self.part1
    solve[0]
  end

  def self.part2
    solve[1]
  end
end