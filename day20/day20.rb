# frozen_string_literal: true

module Day20
  def self.input
    iea, _, *image = File.read(File.join(__dir__, 'input.txt')).split("\n")
    image.map(&:chars)
    return iea, image
  end

  def self.solve(iterations)
    iea, image = input
    iterations.times do |i|
      output_image = []
      (-1..image.size).each do |y|
        (-1..image[0].size).each do |x|
          pixels = []
          (-1..1).each do |dy|
            (-1..1).each do |dx|
              tx = x + dx
              ty = y + dy
              if ty >= 0 && tx >= 0 && ty < image.size && tx < image[0].size
                pixels << image[ty][tx]
              else
                pixels << (i % 2 == 1 ? iea[0] : '.')
              end
            end
          end
          idx = pixels.join.tr('#.', '10').to_i(2)
          output_image[y + 1] ||= []
          output_image[y + 1][x + 1] = iea[idx]
        end
      end
      image = output_image
    end

    # puts image.map(&:join)
    image.flatten.count('#')
  end

  def self.part1
    solve(2)
  end

  def self.part2
    solve(50)
  end
end