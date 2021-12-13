# frozen_string_literal: true

module Day13
  def self.input
    points, folds = File.read(File.join(__dir__, 'input.txt')).split("\n\n")
    points = points.split.map { |p| p.split(?,).map(&:to_i) }
    folds = folds.split(?\n).map { |f| f=f.split(?=); [f[0][-1], f[1].to_i] }

    [points, folds]
  end

  def self.apply_folds(points, folds)
    folds.each do |direction, position|
      points.map! do |x, y|
        if direction == ?y && y > position
          y = position - (y - position)
        elsif direction == ?x && x > position
          x = position - (x - position)
        end
        [x, y]
      end
    end
  end
  
  def self.part1
    points, folds = input
    apply_folds(points, folds[..0])
    points.uniq.size
  end
  
  def self.part2
    points, folds = input
    apply_folds(points, folds)
    
    #
    # Draw code
    #
    xmax = points.map{|p|p[0]}.max
    ymax = points.map{|p|p[1]}.max
    ascii = Array.new(ymax+1) { Array.new(xmax+1, ' ') }

    for y in 0..ymax
      for x in 0..xmax
        if points.include?([x, y])
          ascii[y][x] = '#'
        end
      end
    end
    ascii
  end
end