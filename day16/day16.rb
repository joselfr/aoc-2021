# frozen_string_literal: true

module Day16
  def self.input
    d = File.read(File.join(__dir__, 'input.txt'))
    d.chars.map{ |c| c.to_i(16).to_s(2).rjust(4, ?0) }.join.chars
  end

  OPERATORS = [ :sum, :product, :minimum, :maximum, nil, :gthan, :lthan, :equal ]


  def self.exec_operation(operation)
    res = case operation[:operator]
    when :sum
      operation[:data].sum{ |o| o[:data] }
    when :product
      operation[:data].reduce(1){ |a, o| a * o[:data] }
    when :minimum
      operation[:data].min_by{ |o| o[:data] }[:data]
    when :maximum
      operation[:data].max_by{ |o| o[:data] }[:data]
    when :gthan
      operation[:data][0][:data] > operation[:data][1][:data] ? 1 : 0
    when :lthan
      operation[:data][0][:data] < operation[:data][1][:data] ? 1 : 0
    when :equal
      operation[:data][0][:data] == operation[:data][1][:data] ? 1 : 0
    end
    { version: operation[:version], type: :literal, data: res, version_sum: operation[:version_sum] }
  end

  def self.parse_packet(packet, depth=0)
    version = packet.shift(3).join.to_i(2)
    type = packet.shift(3).join.to_i(2)
    operation = nil
    case type
    when 4 # Literal
      literal = []
      loop do
        e,*b = packet.shift(5)
        literal += b
        break if e == ?0
      end
      return { version: version, type: :literal, data: literal.join.to_i(2), version_sum: version }
    else # Operator
      sub_packet_type_length = packet.shift == ?1 ? 11 : 15

      if sub_packet_type_length == 15
        sub_packets_length = packet.shift(sub_packet_type_length).join.to_i(2)
        sub_packets = []
        while sub_packets_length > 0
          before_size = packet.size
          sub_packets << parse_packet(packet, depth + 1)
          after_size = packet.size
          sub_packets_length -= (before_size - after_size)
        end
        operation = { version: version, type: :operator, operator: OPERATORS[type], data: sub_packets, version_sum: version + sub_packets.sum{ |p| p[:version_sum] } }
      else
        sub_packet_count = packet.shift(sub_packet_type_length).join.to_i(2)
        sub_packets = []
        shift_value = (sub_packet_count > 0) ? packet.size / sub_packet_count : 0
        sub_packet_count.times do
          sub_packets << parse_packet(packet, depth + 1)
        end
        operation =  { version: version, type: :operator, operator: OPERATORS[type], data: sub_packets, version_sum: version + sub_packets.sum{ |p| p[:version_sum] } }
      end
    end

    exec_operation(operation)
  end

  def self.part1
    parse_packet(input)[:version_sum]
  end

  def self.part2
    parse_packet(input)[:data]
  end
end