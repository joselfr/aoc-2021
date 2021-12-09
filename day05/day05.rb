# frozen_string_literal: true

module Day05
  def self.input
    File.read(File.join(__dir__, 'input.txt')).scan(/\d+/).map(&:to_i).each_slice(4).to_a
  end

  def self.solve(&block)
    vents = input

    #
    # Apply filter if block given
    #
    vents.filter!(&block) if block_given?

    #
    # Define all lines points
    #
    points = vents.map do |x1, y1, x2, y2|
      xstep = (x2 <=> x1)
      ystep = (y2 <=> y1)

      ipoints = []
      xstart = x1
      ystart = y1
      while xstart != x2 || ystart != y2
        ipoints << [xstart, ystart]
        xstart += xstep
        ystart += ystep
      end
      ipoints << [xstart, ystart]
      ipoints
    end

    points.flatten.each_slice(2).tally.count { |_k, v| v > 1 }
  end

  def self.part1
    solve { |x1, y1, x2, y2| x1 == x2 || y1 == y2 }
  end

  def self.part2
    solve
  end
end