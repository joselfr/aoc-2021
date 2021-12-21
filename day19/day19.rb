# frozen_string_literal: true
require 'matrix'

module Day19
  def self.input
    lines = File.read(File.join(__dir__, 'input.txt')).split(?\n)
    scannners = []
    scanner_id = 0
    lines.each do |line|
      if line.index('scanner')
        scanner_id = line.split[2].to_i
        scannners[scanner_id] ||= []
      elsif line.index(?,)
        scannners[scanner_id] << Matrix[line.split(?,).map(&:to_i)]
      end
    end
    scannners
  end

  DEG90 = Math::PI / 2

  X90_ROT = Matrix[
    [1, 0, 0],
    [0, Math.cos(DEG90), -Math.sin(DEG90)],
    [0, Math.sin(DEG90), Math.cos(DEG90)]
  ]

  Y90_ROT = Matrix[
    [Math.cos(DEG90), 0, Math.sin(DEG90)],
    [0, 1, 0],
    [-Math.sin(DEG90), 0, Math.cos(DEG90)]
  ]

  Z90_ROT = Matrix[
    [Math.cos(DEG90), -Math.sin(DEG90), 0],
    [Math.sin(DEG90), Math.cos(DEG90), 0],
    [0, 0, 1]
  ]

  def self.appy_rotation(m, rot)
    (m * rot).map(&:round)
  end

  def self.compare_scanners(s1, s2)
    for i in 0...s1.size
      s1_p1 = s1[i]
      for j in 0...s1.size
        next if i == j
        s1_p2 = s1[j]
        for k in 0...s2.size
          s2_p1 = s2[k]
          for l in 0...s2.size
            next if k == l
            s2_p2 = s2[l]

            if (s1_p1 - s1_p2) == (s2_p1 - s2_p2) && (s1_p1 - s2_p1) == (s1_p2 - s2_p2)
              delta = s1_p1 - s2_p1
              s2.map! { |p| p + delta }
              if (s1 & s2).size >= 12
                return delta
              else
                return nil
              end
            end
          end
        end
      end
    end
    return nil
  end

  #
  # Very slow solution takes ~= 7 hours to run
  #
  def self.solve
    scanners = input
    scanners_positions = [Matrix[[0, 0, 0]]]
    replaced_scanners = [scanners.shift]
    while scanners.size > 0
      # Go through each 24 possible positions
      puts "Still #{scanners.size} scanners left"
      catch :loop do
        replaced_scanners.each do |replaced_scanner|
          scanners.each_with_index do |scanner, idx|
            for x in 0..1
              for y in [1,3,0,2][(x * 2)..]
                for z in 0..3
                  rotated_scanner = []
                  scanner.each do |coo|
                    x.times { coo = appy_rotation(coo, X90_ROT) }
                    y.times { coo = appy_rotation(coo, Y90_ROT) }
                    z.times { coo = appy_rotation(coo, Z90_ROT) }
                    rotated_scanner << coo
                  end

                  delta = compare_scanners(replaced_scanner, rotated_scanner)
                  if delta
                    scanners_positions << delta
                    puts " -> Found common points between scanners delta -> #{delta}"
                    replaced_scanners.unshift(rotated_scanner)
                    scanners.slice!(idx)
                    throw :loop
                  end
                end
              end
            end
          end
        end
      end
    end

    max_manhattan = scanners_positions.product(scanners_positions).map { |s1, s2| (s1 - s2).map(&:abs).sum }.max
    nb_beacons = replaced_scanners.flatten.uniq.size
    return nb_beacons, max_manhattan
  end

  def self.part1
    solve[0]
  end

  def self.part2
    solve[1]
  end
end