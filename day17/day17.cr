# frozen_string_literal: true
class Vector
  property :x
  property :y

  def initialize(@x : Int32, @y : Int32)
  end

  def clone
    Vector.new(@x, @y)
  end

  def +(v)
    @x += v.x
    @y += v.y
    self
  end
end

module Day17

  def self.input
    File.read(File.join(__DIR__, "input.txt")).scan(/(\-?\d+)..(\-?\d+)/).map { |m| (m[1].to_i..m[2].to_i).as(Range(Int32,Int32)) }
  end

  def self.solve
    xrange, yrange = input
    good_vels = [] of Vector
    maxy = 0

    (0..xrange.max).to_a.cartesian_product((yrange.min..(yrange.min * -1)).to_a).each do |xvel, yvel|
      pos = Vector.new(0,0)
      vel = Vector.new(xvel, yvel)
      init_vel = vel.clone
      step_maxy = 0
      loop do
        pos += vel

        step_maxy = pos.y if pos.y > step_maxy
        if xrange.covers?(pos.x) && yrange.covers?(pos.y)
          good_vels << init_vel
          maxy = step_maxy if step_maxy > maxy
          break
        end

        vel.x -= 1 if vel.x != 0
        vel.y -= 1
        break if pos.x > xrange.max || pos.y < yrange.min
      end
    end
    return maxy, good_vels.size
  end

  def self.part1
    solve[0]
  end

  def self.part2
    solve[1]
  end
end

require "benchmark"
puts "-> #{Benchmark.measure { puts Day17.part2 }.real} s"