# frozen_string_literal: true

module Day12
  def self.input
    links = File.read(File.join(__dir__, 'input.txt')).split(?\n).map{ |l| l.split(?-) }
    # Clean links
    links.map! do |l|
      if l[0] == 'end' || l[1] == 'start'
        l.reverse
      elsif !l.include?('start') && !l.include?('end')
        [l, l.reverse]
      else
        l
      end
    end

    links.flatten.each_slice(2).to_a
  end
  
  def self.count_paths(from, links, visited=[], &block)
    return 0 if block.call(visited.filter{ |v| v =~ /^[a-z]+$/ }, from)
    return 1 if from == 'end'
    valid = 0
    visited << from
    from_links = links.filter { |f, t| f == from }
    from_links.each do |f, t|
      valid += count_paths(t, links, visited.clone, &block)
    end
    valid
  end

  def self.part1
    links = input
    count_paths('start', links, []) { |v, f| v.include?(f) }
  end
  
  def self.part2
    links = input
    count_paths('start', links, []) { |v, f| ((v + [f]).tally.values.tally[2] || 0) > 1 || (v + [f]).tally.values.tally[3] != nil  }
  end
end