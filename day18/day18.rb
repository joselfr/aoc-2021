# frozen_string_literal: true
require 'json'

module Day18
  def self.process_line(line)
    line.chars.map { |c| c =~ /[0-9]/ ? c.to_i : c }.reject { |c| c == ' ' }
  end

  def self.input
    File.read(File.join(__dir__, 'input.txt')).split(?\n).map{ |line| process_line(line) }
  end

  def self.print_debug(n)
    puts n.join
  end

  def self.get_integer_index(pair, i, d)
    while i < pair.size && i > 0
      if pair[i].is_a?(Integer)
        return i
      end
      i += d
    end
    return nil
  end

  def self.explode(pair)
    depth = 0
    last_left_integer_index = nil
    left_rest = nil
    for i in 0..(pair.size - 1)
      if pair[i] == "["
        depth += 1
      elsif pair[i] == "]"
        depth -= 1
      end

      if depth > 4 && pair[i].is_a?(Integer) && pair[i + 2].is_a?(Integer)
        left_integer_index = get_integer_index(pair, i - 1, -1)
        right_integer_index = get_integer_index(pair, i + 3, 1)
        if left_integer_index
          pair[left_integer_index] += pair[i]
        end
        if right_integer_index
          pair[right_integer_index] += pair[i + 2]
        end
        pair[(i - 1)..(i + 3)] = 0
        return true
      end
    end
    return false
  end

  def self.split(pair)
    for i in 0...pair.size
      if pair[i].is_a?(Integer) && pair[i] > 9
        pair[i] = [ "[", (pair[i] / 2.0).floor, ",", (pair[i] / 2.0).ceil, "]" ]
        pair.flatten!
        return true
      end
    end
    return false
  end

  def self.addition(n1, n2)
    n = ["["] + n1 + [","] + n2 + ["]"]
    changes = true
    while changes
      changes = false
      while (explode(n))
        changes = true
      end

      if (split(n))
        changes = true
      end
    end
    return n
  end

  def self.magnitude(n)
    m = 0
    (0..1).each do |i|
      if n[i].is_a?(Integer)
        m += (3 - i) * n[i]
      else
        m += (3 - i) * magnitude(n[i])
      end
    end
    m
  end

  def self.part1
    n = input.reduce{ |a,b| addition(a, b) }
    # Unflatten
    n = eval(n.join)
    magnitude(n)
  end

  def self.part2
    nbs = input
    nbs.product(nbs).map{ |a,b| (a == b) ? 0 : magnitude(eval(addition(a, b).join))}.max
  end
end